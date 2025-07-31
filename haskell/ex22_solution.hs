-- Save as Main.hs and run with `runhaskell Main.hs`

-- We need this import for `toList`.
import Data.Foldable

-- The corrected data type definition for a Binary Tree.
data BinaryTree a = Leaf a | Branch a (BinaryTree a) (BinaryTree a) deriving (Show)

-- The corrected Foldable instance for an in-order traversal.
instance Foldable BinaryTree where
  foldr f z (Leaf v) = f v z
  foldr f z (Branch v l r) = foldr f (f v (foldr f z r)) l

-- The main function to demonstrate the code.
main :: IO ()
main = do
  putStrLn "--- Demonstrating the In-Order Foldable instance for BinaryTree ---"
  
  -- Let's create a binary search tree so the in-order traversal is obvious.
  let myTree = Branch 4 (Branch 2 (Leaf 1) (Leaf 3)) (Leaf 5)
  
  putStrLn $ "\nOriginal Tree: " ++ show myTree
  
  putStrLn "\n--- Using functions from the Foldable typeclass ---"
  
  -- The `toList` function is the best way to see the traversal order.
  -- For our tree, an in-order traversal should produce a sorted list.
  putStrLn $ "In-order traversal with toList: " ++ show (toList myTree)
  
  putStrLn $ "Sum of all elements with sum: " ++ show (sum myTree)
  
  putStrLn $ "Number of nodes with length: " ++ show (length myTree)
  
  putStrLn $ "Maximum element with maximum: " ++ show (maximum myTree)
  
  putStrLn "\nDemonstration complete. Notice how `toList` returns the elements in sorted (in-order) sequence."

