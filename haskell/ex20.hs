{-
Exercise 20: A Two-Parameter Functor Consider the following data type: data Result e v = Error e | Success v This is a common way to handle operations that can fail. Make Result e v an instance of Functor. Which type variable should fmap apply to? Why?
-}

data Result e v = Error e | Success v

instance Functor (Result e) where
  fmap _ (Error e) = Error e
  fmap f (Success v) = Success (f v)

