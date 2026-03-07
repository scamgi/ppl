{-
Exercise 27: A Foldable Deque (from 2022.07.06) Consider a Deque a implemented with two lists: data Deque a = Deque [a] [a] where the first list is the front and the second is the reversed back. Make this an instance of Foldable. A helper function toList :: Deque a -> [a] would make this much easier.
-}

{- WRONG
data Deque a = Deque [a] [a]

toList :: Deque a -> [a]
toList lst = concatMap toList lst

instance Foldable Deque where
  foldr f z v = f (toList v) z
-}

data Deque a = Deque [a] [a] deriving Show

-- The correct toList helper function
toList :: Deque a -> [a]
toList (Deque front back) = front ++ reverse back

-- The correct Foldable instance
instance Foldable Deque where
  -- To fold a Deque, just convert it to a list and use the list's foldr.
  foldr f z deq = foldr f z (toList deq)

-- TODO: check this exercise again, because it was very difficult!