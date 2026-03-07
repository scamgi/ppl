{-
Exercise 38: A Monad for Maybe Make the Maybe a type from Exercise 29 an instance of Monad. The >>= (bind) operator takes a wrapped value and a function that returns a new wrapped value, allowing for computations to be chained together.
-}

data Maybe a = Just a | Nothing

instance Functor Maybe where
  fmap f Nothing = Nothing
  fmap f (Maybe v) = Just (f v)

instance Applicative Maybe where
  pure val = Just val

  (Just f) <*> (Just v) = Just (f v)

  _ <*> _ = Nothing

instance Monad Maybe where
  (Maybe val) >>= f =
    let (Maybe next_val) = f val
    in Maybe next_val

