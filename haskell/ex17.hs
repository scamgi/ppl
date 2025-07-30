{-
Exercise 17: A Functor for BinaryTree Make the BinaryTree a from Exercise 6 an instance of Functor.
-}

data BinaryTree a = Leaf a | Branch (BinaryTree a) (BinaryTree a) deriving (Show)

instance Functor BinaryTree where
  fmap f (Leaf a) = Leaf (f a)
  fmap f (Branch l r) = Branch (fmap f l) (fmap f r)

main :: IO ()
main = do
  putStrLn "Let's build a tree of numbers!"
  -- A tree that looks like this:
  --     / \
  --    /   \
  -- Leaf 1  Branch
  --         /   \
  --      Leaf 5 Leaf 10
  let myTree = Branch (Leaf 1) (Branch (Leaf 5) (Leaf 10))
  putStrLn ("Original tree: " ++ show myTree)
  putStrLn ""

  putStrLn "Now, let's get a tool. How about a function that doubles everything?"
  let double = (*2)
  putStrLn "Applying the 'double' function with fmap..."
  
  -- Here is the magic! fmap applies `double` to every Leaf in the tree.
  let doubledTree = fmap double myTree
  putStrLn ("Resulting tree:  " ++ show doubledTree)
  putStrLn ""

  putStrLn "Let's try another tool! One that turns numbers into little strings."
  let stringify n = "Value(" ++ show n ++ ")"
  putStrLn "Applying the 'stringify' function with fmap..."

  let stringTree = fmap stringify myTree
  putStrLn ("Resulting tree:  " ++ show stringTree)

