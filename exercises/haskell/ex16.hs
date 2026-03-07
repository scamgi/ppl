{-
Exercise 16: A Functor for LinkedList Make the LinkedList a from Exercise 5 an instance of Functor by implementing fmap.
-}


data LinkedList a = Empty | Node a (LinkedList a)


-- We need to be able to show the list to print it.
-- This is from your earlier exercise.
instance (Show a) => Show (LinkedList a) where
  show Empty = "Empty"
  show (Node val rest) = show val ++ " -> " ++ show rest

{- ALL WRONG
instance Functor f (LinkedList a) where
  Empty = Empty
  Node l r = Node (f l) (f r)
-}

-- Now, the Functor instance. This is the part we're correcting.
instance Functor LinkedList where
  -- fmap takes a function and a LinkedList.
  -- Case 1: The list is Empty. Return an Empty list.
  fmap _ Empty = Empty
  -- Case 2: The list is a Node.
  -- Apply the function `f` to the value `val`.
  -- Recursively call `fmap f` on the rest of the list.
  fmap f (Node val rest) = Node (f val) (fmap f rest)

-- How to show this on a screen: A main function!
main = do
  -- 1. Let's create a list of numbers.
  let myNumbers = Node 10 (Node 20 (Node 30 Empty))
  putStrLn ("Original list:  " ++ show myNumbers)

  -- 2. Let's create a simple function, like doubling a number.
  let double = (*2)

  -- 3. Now use fmap to apply our function to our list!
  let doubledNumbers = fmap double myNumbers
  putStrLn ("Doubled list:   " ++ show doubledNumbers)

  -- 4. Let's try another one! Convert numbers to strings.
  let showAndAddStars n = "***" ++ show n ++ "***"
  let stringList = fmap showAndAddStars myNumbers
  putStrLn ("Stringified list: " ++ show stringList)

