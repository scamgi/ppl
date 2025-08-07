data Maybe a = Just a | Nothing

instance Functor Maybe where
  fmap _ Nothing  = Nothing
  fmap f (Just v) = Just (f v)

instance Applicative Maybe where
  pure v = Just v

  (Just f) <*> (Just v) = Just (f v)
  _        <*> _        = Nothing

instance Monad Maybe where
  -- If the starting value is Nothing, the entire chain of operations stops.
  Nothing >>= _ = Nothing
  -- If the starting value is a 'Just', unwrap the value 'val' and pass it
  -- to the next function 'f'. The function 'f' will return the next Maybe.
  (Just val) >>= f = f val

