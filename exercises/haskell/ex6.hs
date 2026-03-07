{-
Exercise 6: A Simple Binary Tree Define a data type BinaryTree a that can store values of any type a. A tree can be either a Leaf holding a value or a Branch holding a value and two sub-trees (BinaryTree a).
-}

data BinaryTree a = Leaf a | Branch (BinaryTree a) (BinaryTree a) deriving (Show)

countNodes :: BinaryTree a -> Int
countNodes (Leaf _) = 1
countNodes (Branch left right) = 1 + countNodes left + countNodes right

main :: IO ()
main = do
  let myTree = Branch (Branch (Leaf 'c') (Leaf 'd')) (Leaf 'e')

  print myTree
  print (countNodes myTree)
