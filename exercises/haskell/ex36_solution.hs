data T x y z = T (x -> y -> z)

-- The type `z` is the one we are mapping over.
instance Functor (T x y) where
  -- fmap :: (a -> b) -> T x y a -> T x y b
  -- Unpacked:
  -- fmap :: (a -> b) -> T (x -> y -> a) -> T (x -> y -> b)
  fmap g (T f) = T (\x_val y_val -> g (f x_val y_val))

instance Applicative (T x y) where
  -- pure :: a -> T x y a
  -- Unpacked:
  -- pure :: a -> T (x -> y -> a)
  -- We need a function x -> y -> a. We can create one that ignores its arguments
  -- and always returns 'val'.
  pure val = T (\_ _ -> val)

  -- <*> :: T x y (a -> b) -> T x y a -> T x y b
  -- Unpacked:
  -- <*> :: T (x -> y -> (a -> b)) -> T (x -> y -> a) -> T (x -> y -> b)
  (T f_func) <*> (T v_func) = T (\x_val y_val -> (f_func x_val y_val) (v_func x_val y_val))

