data W x y = W ([x] -> [y])

instance Functor (W x) where
  -- fmap :: (a -> b) -> W x a -> W x b
  -- Unpacked: fmap :: (a -> b) -> W ([x] -> [a]) -> W ([x] -> [b])
  fmap g (W f) = W (\x_list -> fmap g (f x_list))
  -- A more elegant way to write this is with function composition:
  -- fmap g (W f) = W (fmap g . f)

instance Applicative (W x) where
  -- pure :: a -> W x a
  -- Unpacked: pure :: a -> W ([x] -> [a])
  -- This implementation is correct.
  pure val = W (\_ -> [val])

  -- <*> :: W x (a -> b) -> W x a -> W x b
  -- Unpacked: <*> :: W ([x] -> [a -> b]) -> W ([x] -> [a]) -> W ([x] -> [b])
  (W f_func) <*> (W g_func) = W (\x_list -> (f_func x_list) <*> (g_func x_list))

