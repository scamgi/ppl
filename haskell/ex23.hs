-- this is all generated with Gemini

-- Save as Main.hs and run with `runhaskell Main.hs`

-- We still need this import because `toList` is NOT in the Prelude.
import Data.Foldable (toList)

-- THE FIX: The line `import Data.Monoid (concatMap)` has been removed.
-- `concatMap` is available by default from the Prelude.

-- Data definition from Exercise 7
data Gtree a = Gtree a [Gtree a] deriving (Show)

-- Helper function to flatten the tree into a list (pre-order)
-- This function works perfectly and needs no changes.
gtree2list :: Gtree a -> [a]
gtree2list (Gtree x children) = x : concatMap gtree2list children

-- The Foldable instance using the helper function
-- This implementation is correct.
instance Foldable Gtree where
  foldr f z gtree = foldr f z (gtree2list gtree)

-- The main function to demonstrate the code
main :: IO ()
main = do
  putStrLn "--- Demonstrating the Foldable instance for Gtree ---"
  
  -- A sample tree:
  --      1
  --     / \
  --    2   3
  --        |
  --        4
  --        |
  --        5
  let myGTree = Gtree 1 [
                  Gtree 2 [],
                  Gtree 3 [
                    Gtree 4 [
                      Gtree 5 []
                    ]
                  ]
                ]
  
  putStrLn $ "\nOriginal Tree: " ++ show myGTree

  putStrLn $ "Tree flattened: " ++ show (gtree2list myGTree)
  
  putStrLn "\n--- Using functions from the Foldable typeclass ---"
  
  -- `toList` is the best way to see the pre-order traversal
  putStrLn $ "Pre-order traversal with toList: " ++ show (toList myGTree)
  
  putStrLn $ "Sum of all elements with sum: " ++ show (sum myGTree)
  
  putStrLn $ "Number of nodes with length: " ++ show (length myGTree)
  
  putStrLn $ "Maximum element with maximum: " ++ show (maximum myGTree)
  
  putStrLn "\nDemonstration complete."
