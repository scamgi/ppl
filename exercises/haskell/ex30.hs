{-
Exercise 30: Applicative for a LinkedList Make the LinkedList a from Exercise 5 an instance of Applicative. The standard behavior for lists is that <*> applies every function in the first list to every value in the second list, creating a "cartesian product" of results.
-}

data LinkedList a = Empty | Node a (LinkedList a) deriving (Show)

instance Functor LinkedList where
  fmap f Empty = Empty
  fmap f (Node value rest) = Node (f value) (fmap f rest)

instance Applicative LinkedList where
  pure val = Node val (Empty)

  (Node f rest) <*> (Node v rest) = Empty
  (Node f Empty) <*> (Node v rest) = (Node (f v) rest)
  (Node f rest) <*> (Node v Empty) = (Node (f v) rest)
  _ <*> _ = Empty

