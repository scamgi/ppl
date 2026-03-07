{-
Exercise 4: Your First Recursive Data Type Define a data type for a singly-linked list of integers, IntList. It should either be Empty or a Node that contains an Int and another IntList.
-}

data IntList = Empty | Node Int IntList deriving (Show)


sumIntList :: IntList -> Int
sumIntList Empty = 0
sumIntList (Node value restOfTheList) = value + sumIntList restOfTheList


main :: IO ()
main = do
  let myList = Node 5 (Node 10 (Node 15 Empty))

  let emptyList = Empty

  putStrLn "Here is our custom integer list:"
  print myList

  putStrLn "\nHere is the sum of its elements:"
  print (sumIntList myList)

  putStrLn "\nHere is the sum of an empty list:"
  print (sumIntList emptyList)
