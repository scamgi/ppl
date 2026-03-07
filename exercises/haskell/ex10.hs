{-
Exercise 10: Describing a Complex Data Type (from 2025.01.20) Consider the following data definition: data T a = A | B (T a) a | C a a In your own words, describe what this data structure represents. How would you construct a value of type T Int that uses all three constructors?
-}

-- This data is a data where I can have either an A, a C a a, or a value B (T a) a that calls T a recursively, so there I could have again A | B (T a) a | C a a
