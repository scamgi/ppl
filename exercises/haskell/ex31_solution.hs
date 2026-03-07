-- The data structure and Functor are the same as before.
data LinkedList a = Empty | Node a (LinkedList a) deriving (Show)

instance Functor LinkedList where
  fmap f Empty = Empty
  fmap f (Node value rest) = Node (f value) (fmap f rest)

-- This is the new "zip-like" Applicative instance
instance Applicative LinkedList where
  -- `pure` still creates a single-element list.
  pure val = Node val Empty

  -- Base Case 1: If the list of functions is empty, the result is empty.
  Empty <*> _ = Empty
  
  -- Base Case 2: If the list of values is empty, the result is empty.
  _ <*> Empty = Empty
  
  -- Recursive Step: Apply the head function to the head value,
  -- then recursively zip the rest of the lists.
  (Node f fs) <*> (Node v vs) = Node (f v) (fs <*> vs)

-- A main function to demonstrate the new behavior.
main :: IO ()
main = do
  -- A list of functions: (+10) and (*2)
  let functions = Node (+10) (Node (*2) Empty)

  -- A list of values with the same length: 1 and 5
  let values = Node 1 (Node 5 Empty)
  
  -- A longer list of values: 1, 5, 100, 200
  let longValues = Node 1 (Node 5 (Node 100 (Node 200 Empty)))

  putStrLn "Zipping lists of the same length:"
  -- Expected: (+10) applies to 1, (*2) applies to 5.
  -- Result: Node 11 (Node 10 Empty)
  print (functions <*> values)

  putStrLn "\nZipping lists of different lengths:"
  -- The 'functions' list is shorter, so the process stops after 2 elements.
  -- Expected: (+10) applies to 1, (*2) applies to 5. The 100 and 200 are ignored.
  -- Result: Node 11 (Node 10 Empty)
  print (functions <*> longValues)
