{-
Exercise 31: A "Zip-like" Applicative Let's re-implement the Applicative instance for LinkedList a, but this time with a "zip-like" behavior. (<*>) should apply the first function to the first value, the second function to the second value, and so on. The resulting list should be as long as the shorter of the two input lists.
-}

data LinkedList a = Empty | Node a (LinkedList a) deriving (Show)

instance Functor LinkedList where
  fmap f Empty = Empty
  fmap f (Node value rest) = Node (f value) (fmap f rest)

instance Applicative LinkedList where
  pure val = Node val Empty

  Empty <*> _ = Empty

