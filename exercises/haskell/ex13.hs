{-
Exercise 13: Showing a LinkedList Make the LinkedList a from Exercise 5 an instance of Show (with the appropriate type constraint on a). A list containing 1, 2, 3 should be displayed as 1 -> 2 -> 3 -> Empty.
-}

data LinkedList a = Empty | Node a (LinkedList a)

-- BE CAREFUL HERE: YOU NEED TO ADD THE CONTRAIN "(Show a) =>" TO MAKE EVERYTHING WORK
instance (Show a) => Show (LinkedList a) where
  show (Empty) = "Empty"
  show (Node a b) = (show a) ++ " -> " ++ (show b)

main = do
  let lList = Node 1 (Node 2 (Node 3 Empty))
  putStrLn (show lList)

