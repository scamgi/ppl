{-
Exercise 44: A Monad for the W Function Wrapper (from 2024.06.06) Make the W x type from Exercise 37 an instance of Monad. data W x y = W ([x] -> [y])

>>= :: W x a -> (a -> W x b) -> W x b This is tricky. (W g) >>= f means you have a function g :: [x] -> [a] and another function f :: a -> W x b. You need to produce a final function of type [x] -> [b]. This involves running g, then for each resulting a, applying f to get a new function, and then figuring out how to combine all those resulting functions.
-}

data W x y = W ([x] -> [y])

instance Functor (W x) where
  fmap :: (a -> b) -> W x a -> W x b
  fmap g (W f) = W (map g . f)

instance Applicative (W x) where
  pure :: a -> W x a
  pure val = W (\_ -> [val])

  (<*>) :: W x (a -> b) -> W x a -> W x b
  (W fs) <*> (W vs) = W (\xs -> fs xs <*> vs xs)

instance Monad (W x) where
  (>>=) :: W x a -> (a -> W x b) -> W x b
  (W g) >>= f = W (\xs ->    -- 1. We define a new function that takes [x]
    let
      as         = g xs                            -- 2. Run g to get [a]
      ws         = map f as                        -- 3. Apply f to each a, getting [W x b]
      -- Now we need to get the results out of `ws`.
      -- We unwrap each W to get its function, and apply xs.
      unwrappedFs = map (\(W h) -> h) ws           -- 4. Get a list of functions: [[x] -> [b]]
      results     = map (\h -> h xs) unwrappedFs   -- 5. Run each function with xs, getting [[b]]
    in
      concat results                             -- 6. Flatten the result, getting [b]
    )
