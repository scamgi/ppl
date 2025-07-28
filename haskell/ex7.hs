{-
Exercise 7: A Tree with a Variable Number of Children (from 2022.02.10) Define a data structure Gtree a for a general tree. Each node should contain some data of type a and a list of children, where each child is also a Gtree a.
-}

-- The data definition from above.
-- We derive 'Show' so we can print it to the console.
data Gtree a = Gtree a [Gtree a] deriving (Show)

-- A function to count all nodes in a Gtree.
countNodes :: Gtree a -> Int
-- The count of a node is 1 (for itself) plus the sum of the counts of all its children.
countNodes (Gtree _ children) = 1 + sum (map countNodes children)
-- 'map countNodes children' applies the countNodes function to every child tree in the list,
-- producing a list of numbers (e.g., [1, 2, 1]).
-- 'sum' then adds up that list of numbers (e.g., 1 + 2 + 1 = 4).


main :: IO ()
main = do
  -- To make it readable, we can define the leaves first.
  -- A leaf is just a Gtree node with an empty list of children.
  let nodeB = Gtree 'B' []
  let nodeE = Gtree 'E' []
  let nodeD = Gtree 'D' []

  -- Now define the nodes that have children.
  let nodeC = Gtree 'C' [nodeE]

  -- Finally, define the root node. Its list of children contains
  -- the nodes we defined above.
  let rootNodeA = Gtree 'A' [nodeB, nodeC, nodeD]

  putStrLn "Here is the general tree:"
  -- The derived 'Show' instance gives us a nice, readable output.
  print rootNodeA

  putStrLn "\nTotal number of nodes in the tree:"
  print (countNodes rootNodeA)
