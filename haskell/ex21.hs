{-
Exercise 21: A Foldable LinkedList Make the LinkedList a from Exercise 5 an instance of Foldable by implementing foldr.
-}

import Data.Foldable

data LinkedList a = Empty | Node a (LinkedList a)

instance Show a => Show (LinkedList a) where
  show Empty = "Empty"
  show (Node x r) = show x ++ " -> " ++ show r

instance Foldable LinkedList where
  foldr f z (Empty) = z
  foldr f z (Node l r) = f l (foldr f z r)

main :: IO ()
main = do
  putStrLn "--- Demonstrating the Foldable instance for LinkedList ---"
  
  let myIntList = Node 10 (Node 20 (Node 30 Empty))
  putStrLn $ "Original custom list: " ++ show myIntList

  putStrLn "\n--- Using functions from the Foldable typeclass ---"
  
  putStrLn $ "Converted to standard list with toList: " ++ show (toList myIntList)
  
  putStrLn $ "Number of elements with length: " ++ show (length myIntList)
  
  putStrLn $ "Sum of all elements with sum: " ++ show (sum myIntList)
  
  putStrLn $ "Maximum element with maximum: " ++ show (maximum myIntList)
  
  putStrLn $ "Does the list contain 20? " ++ show (elem 20 myIntList)
  putStrLn $ "Does the list contain 99? " ++ show (elem 99 myIntList)
  
  putStrLn "\n--- Direct use of foldr ---"
  
  let productOfElements = foldr (*) 1 myIntList
  putStrLn $ "Product of all elements (using foldr (*) 1): " ++ show productOfElements
  
  putStrLn "\nDemonstration complete."
