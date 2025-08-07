{-
Exercise 37: Applicative for W (from 2024.06.06) Consider the datatype: data W x y = W ([x] -> [y]). This wraps a function from a list of x to a list of y. Make W x an instance of Applicative.

pure :: a -> W x a
<*> :: W x (a -> b) -> W x a -> W x b`
-}

data W x y = W ([x] -> [y])

instance Functor (W x) where
  -- fmap :: (a -> b) -> W x a -> W x b
  fmap g (W f) = W (\x_val -> g (f x_val))

instance Applicative (W x) where
  pure val = W (\_ -> [val])

  (W f) <*> (W g) = W (\x_val -> (f x_val) (g x_val))
