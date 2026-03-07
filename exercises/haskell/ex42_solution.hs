{-
Exercise 42: A State-and-Maybe Monad (F) (from 2024.02.02)
-}

-- The data type remains the same
data F b a = F (b -> b) a | Null deriving Show

instance Functor (F b) where
  fmap f (F g x) = F g (f x)
  fmap _ Null    = Null

instance Applicative (F b) where
  pure val = F id val

  (F f func) <*> (F g val) = F (g . f) (func val)
  _          <*> _          = Null

instance Monad (F b) where
  return = pure

  -- If the first computation is Null, the whole chain is Null.
  Null >>= _ = Null

  -- If the first computation succeeds with a state function 'g' and value 'x'...
  (F g x) >>= f =
    -- ...we apply the function 'f' to 'x' to get the next computation in the chain.
    let nextComputation = f x
    in
    -- Then we pattern match on that next computation.
    case nextComputation of
      -- If it's Null, the chain ends.
      Null -> Null
      -- If it succeeds with a new state function 'h' and a new value 'y'...
      (F h y) ->
        -- ...the final result has the new value 'y', and a state function
        -- that is the composition of the new function 'h' and the original function 'g'.
        F (h . g) y

-- Example Usage:
-- Let's define two simple functions that work on an Int state.
addOne :: Int -> F Int Int
addOne x = F (+1) (x + 10) -- Adds 1 to the state, returns x+10

multTwo :: Int -> F Int Int
multTwo x = F (*2) (x * 10) -- Multiplies state by 2, returns x*10

-- Chain them together: start with 5
computation = addOne 5 >>= multTwo

-- Let's see what `computation` is:
-- 1. `addOne 5` evaluates to `F (+1) 15`.
-- 2. `>>=` is called: `(F (+1) 15) >>= multTwo`.
-- 3. The `f` function is `multTwo`, the value `x` is `15`.
-- 4. `f x` becomes `multTwo 15`, which evaluates to `F (*2) 150`.
-- 5. This is the `nextComputation`. It's not Null.
-- 6. The pattern `F h y` matches `F (*2) 150`. So `h` is `(*2)` and `y` is `150`.
-- 7. The original state function `g` was `(+1)`.
-- 8. The final result is `F ((*2) . (+1)) 150`.

-- So if you ran this computation on a state of 100:
-- The final state would be `(*2) . (+1) $ 100`, which is `2 * (100 + 1) = 202`.
-- The final value is 150.
