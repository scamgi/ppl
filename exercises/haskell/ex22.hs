{-
Exercise 22: A Foldable BinaryTree Make the BinaryTree a from Exercise 6 an instance of Foldable. The fold should process the left subtree, then the root, then the right subtree (an in-order traversal).
-}

data BinaryTree a = Leaf a | Branch a (BinaryTree a) (BinaryTree a) deriving (Show)

instance Foldable BinaryTree where
  foldr f z (Leaf v) = f v z
  foldr f z (Branch v l r) = foldr f (f v (foldr f z l)) r

