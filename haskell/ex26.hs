{-
Exercise 26: A Foldable "Double Content" List (from 2024.09.03) Make the Llist b a from Exercise 8 an instance of Foldable. Remember that the instance is for Foldable (Llist b), so you only fold over the values of type a.
-}

data Llist b a = Empty | Node b a (Llist b a) deriving Show

instance Foldable (Llist b) where
  foldr f z Empty = z
  foldr f z (Node b_value a rest) = f a (foldr f z rest)
