data LinkedList a = Empty | Node a (LinkedList a) deriving (Show)

instance Functor LinkedList where
  fmap f Empty = Empty
  fmap f (Node value rest) = Node (f value) (fmap f rest)

append :: LinkedList a -> LinkedList a -> LinkedList a
append Empty ys = ys
append (Node x xs) ys = Node x (append xs ys)

instance Applicative LinkedList where
  pure val = Node val Empty

  Empty <*> _ = Empty
  (Node f fs) <*> vs = append (fmap f vs) (fs <*> vs)

main :: IO ()
main = do
  -- A list of functions: (+10) and (*2)
  let functions = Node (+10) (Node (*2) Empty)

  -- A list of values: 1, 5, 10
  let values = Node 1 (Node 5 (Node 10 Empty))

  putStrLn "Applying a list of functions to a list of values:"
  print (functions <*> values)

  putStrLn "\nApplying an empty list of functions:"
  
  print ((Empty <*> values) :: LinkedList Integer)
  
  putStrLn "\nApplying an empty list of values:"
  
  print ((functions <*> Empty) :: LinkedList Integer)


