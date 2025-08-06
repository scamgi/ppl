{-
Exercise 33: A Zip-like Applicative for a Binary Tree (from 2023.02.15) The exam asks for a zip-like Applicative for a BBtree: data BBtree a = BBnil | BBtree (BBtree a) a a (BBtree a) Implement Applicative such that <*> combines two trees structurally. For example: (BBtree l f1 f2 r) <*> (BBtree l' v1 v2 r') should result in BBtree (l <*> l') (f1 v1) (f2 v2) (r <*> r') What should happen if the structures don't match (e.g., BBnil <*> BBtree ...)?
-}

data BBtree a = BBnil | BBtree (BBtree a) a a (BBtree a) deriving Show

instance Functor BBtree where
  fmap f BBnil = BBnil
  fmap f (BBtree l v1 v2 r) = BBtree (fmap f l) (f v1) (f v2) (fmap f r)

instance Applicative BBtree where
  pure val = BBtree BBnil val val BBnil

  (BBtree l f1 f2 r) <*> (BBtree l' v1 v2 r') = BBtree (l <*> l') (f1 v1) (f2 v2) (r <*> r')

  _ <*> _ = BBnil


main :: IO ()
main = do
  -- A tree of functions
  let funcTree = BBtree (BBtree BBnil (+1) (+2) BBnil) (*10) (*100) (BBtree BBnil (subtract 1) (subtract 2) BBnil)

  -- A tree of values with the same structure
  let valTree = BBtree (BBtree BBnil 1 1 BBnil) 5 5 (BBtree BBnil 10 10 BBnil)

  -- A tree of values with a different structure (mismatched)
  let mismatchedValTree = BBtree BBnil 5 5 (BBtree BBnil 10 10 BBnil)

  putStrLn "--- 1. Applying trees with matching structures ---"
  -- Expected: The trees are zipped together.
  -- BBtree (BBtree BBnil ((+1) 1) ((+2) 1) BBnil) ((*10) 5) ((*100) 5) (BBtree BBnil ((subtract 1) 10) ((subtract 2) 10) BBnil)
  -- BBtree (BBtree BBnil 2 3 BBnil) 50 500 (BBtree BBnil 9 8 BBnil)
  print (funcTree <*> valTree)

  putStrLn "\n--- 2. Applying trees with mismatched structures ---"
  -- Expected: The `_ <*> _ = BBnil` rule is triggered.
  -- Result: BBtree BBnil 50 500 (BBtree BBnil 9 8 BBnil)
  print (funcTree <*> mismatchedValTree)
  
  putStrLn "\n--- 3. Applying a tree to an empty tree ---"
  -- Expected: The `_ <*> _ = BBnil` rule is triggered.
  -- Result: BBnil
  print (funcTree <*> BBnil)

