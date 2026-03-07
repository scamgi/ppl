data Deque a = Deque [a] [a] deriving Show

toList :: Deque a -> [a]
toList (Deque front back) = front ++ reverse back

instance Foldable Deque where
  foldr f z deq = foldr f z (toList deq)

instance Functor Deque where
  fmap f (Deque a b) = Deque (map f a) (map f b)

instance Applicative Deque where
  pure val = Deque [val] [val]
  (Deque f1 f2) <*> (Deque v1 v2) = Deque (f1 <*> v1) (f2 <*> v2)

instance Monad Deque where
  return = pure

  -- >>= :: Deque a -> (a -> Deque b) -> Deque b
  deq >== f =
    let 
