{-
Exercise 9: A List That Knows Its Length (from 2021.08.31) Define a data structure Slist a that stores both a list of [a] and an Int representing its length. Write a smart constructor makeSlist :: [a] -> Slist a that automatically calculates the length.
-}

data Slist a = Slist [a] Int deriving Show

makeSlist :: [a] -> Slist a
makeSlist xs = Slist xs (length xs)

main = do
  let myList = makeSlist [10, 20, 30]
  print myList
