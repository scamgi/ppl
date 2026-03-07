{-
Exercise 8: A "Double Content" List (from 2024.09.03) Define a data structure Llist b a that represents a list where each node contains two values: one of type a and one of type b.
-}

data Llist b a = Empty | Node b a (Llist b a)
