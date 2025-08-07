{-
Exercise 39: Monad for a LinkedList Make the LinkedList a from Exercise 5 an instance of Monad. xs >>= f should apply f to every element in xs and concatenate the resulting linked lists together.
-}

data LinkedList a = Empty | Node a (LinkedList a) deriving (Show)

instance Functor LinkedList where
  fmap f Empty = Empty
  fmap f (Node val rest) = Node (f val) (fmap f rest)

instance Applicative LinkedList where
  pure val = Node val Empty

  (Node f rest) <*> (Node v rest') =
    Node (f v) (rest <*> rest')
  
  Empty <*> (Node v rest) = Empty

  Empty <*> Empty = Empty

instance Monad LinkedList where
  Empty >>= f = Empty

  (Node x xs) >>= f =
    Node (f x) (xs >>= f)
