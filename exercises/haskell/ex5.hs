{-
Exercise 5: A Generic Linked List Generalize the IntList from the previous exercise into a polymorphic LinkedList a that can hold values of any type a.
-}

data LinkedList a = Empty | Node a (LinkedList a) deriving (Show)

-- A generic function to calculate the length of *any* LinkedList.
-- Notice it works on 'LinkedList a' but returns a concrete 'Int'.
linkedLength :: LinkedList a -> Int
linkedLength Empty = 0
linkedLength (Node _ rest) = 1 + linkedLength rest -- We don't care about the value (_), just that it exists.

main :: IO ()
main = do
  let myLinkedList = Node 'a' (Node 'b' Empty)
  print myLinkedList
  print (linkedLength myLinkedList)

  let emptyList = Empty

  -- Now we print the empty list. We add a type annotation to remove the ambiguity.
  -- We're telling Haskell: "Treat this emptyList as a list of Integers for printing."
  print (emptyList :: LinkedList Int)

  -- The next line will now also work without an error.
  -- The compiler can infer the type from context if needed, but the problem
  -- was specifically with `print` needing a concrete type.
  print (linkedLength emptyList)
