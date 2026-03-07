-- File: LinkedListMonad.hs

-- The data type and Show instance for printing
data LinkedList a = Empty | Node a (LinkedList a)

instance Show a => Show (LinkedList a) where
  show Empty = "Empty"
  show (Node x xs) = show x ++ " -> " ++ show xs

-- Helper function to append two lists
append :: LinkedList a -> LinkedList a -> LinkedList a
append Empty ys = ys
append (Node x xs) ys = Node x (append xs ys)

-- The correct Functor instance
instance Functor LinkedList where
  fmap _ Empty = Empty
  fmap f (Node val rest) = Node (f val) (fmap f rest)

-- The correct Applicative instance (standard, not zip-like)
instance Applicative LinkedList where
  pure val = Node val Empty

  fs <*> vs = foldr append Empty (fmap (`fmap` vs) fs)

-- The correct Monad instance
instance Monad LinkedList where
  Empty >>= f = Empty
  (Node x xs) >>= f = append (f x) (xs >>= f)


-- Example Usage
main :: IO ()
main = do
  let list = Node 1 (Node 2 (Node 3 Empty))

  -- This function takes a number n and returns a list containing n and n*n
  let duplicateAndSquare n = Node n (Node (n*n) Empty)

  putStrLn "Original list:"
  print list
  -- Expected: 1 -> 2 -> 3 -> Empty

  putStrLn "\nApplying a function that doubles each element (fmap):"
  print (fmap (*2) list)
  -- Expected: 2 -> 4 -> 6 -> Empty

  putStrLn "\nApplying a function and concatenating with Monad (>>=):"
  -- This will apply `duplicateAndSquare` to 1, 2, and 3, and
  -- concatenate all the resulting lists.
  print (list >>= duplicateAndSquare)
  -- Expected: 1 -> 1 -> 2 -> 4 -> 3 -> 9 -> Empty

