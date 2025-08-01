{-
Exercise 24: A Foldable Binary/Ternary Tree (from 2021.06.22) Consider the following data type: data BTT a = Nil | B a (BTT a) (BTT a) | T a (BTT a) (BTT a) (BTT a) Make BTT a an instance of Foldable. You must handle all three constructors.
-}

data BTT a = Nil | B a (BTT a) (BTT a) | T a (BTT a) (BTT a) (BTT a) deriving Show

instance Foldable BTT where
  foldr f z (Nil) = z
  foldr f z (B v l r) = foldr f (f v (foldr f z r)) l
  foldr f z (T v l c r) = foldr f (f v (foldr f (foldr f z r) c)) l
    -- Left Subtree -> Value -> Center Subtree -> Right Subtree

