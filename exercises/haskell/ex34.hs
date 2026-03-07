{-
Exercise 34: Applicative for a Tape (from 2023.01.25) Given the following data type for a Turing Machine tape: data Tape a = Tape [a] a [a] -- (left-of-head, at-head, right-of-head) Implement a zip-like Applicative instance. The function should apply to the elements at the head and then zip the left and right tapes.
-}

data Tape a = Tape [a] a [a]

instance Functor Tape where
  fmap f Tape a b c = (fmap f a) (f b) (fmap f c)

instance Applicative Tape where
  pure val = Tape [] val []

  (Tape a b c) <*> (Tape d e f) = (a <*> d) (b e) (c <*> f)

