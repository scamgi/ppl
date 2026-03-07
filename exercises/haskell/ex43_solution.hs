-- The data structure
data Deque a = Deque [a] [a] deriving Show

-- Helper to convert a Deque to a list
toList :: Deque a -> [a]
toList (Deque front back) = front ++ reverse back

-- Helper to convert a list to a balanced Deque
fromList :: [a] -> Deque a
fromList xs =
  let (front, back) = splitAt (length xs `div` 2) xs
  in Deque front (reverse back)

-- This instance is correct and idiomatic.
instance Foldable Deque where
  foldr f z deq = foldr f z (toList deq)

-- This instance is correct.
instance Functor Deque where
  fmap f (Deque a b) = Deque (map f a) (map f b)

-- The Applicative instance should treat the Deque as a single sequence.
instance Applicative Deque where
  pure val = Deque [val] []

  funcs <*> vals = fromList (toList funcs <*> toList vals)

-- The Monad instance leverages the list Monad via helper functions.
instance Monad Deque where
  return = pure

  deq >>= f = fromList (toList deq >>= (toList . f))

-- Example of the Monad in action:
-- Start with a deque of [1, 2, 3]
-- For each element x, create a new deque [x*10, x*10+1]
-- The final result should be [10, 11, 20, 21, 30, 31]

example :: Deque Int
example = fromList [1,2,3] >>= \x -> fromList [x*10, x*10+1]

-- > example
-- Deque [10,11,20] [31,30,21]  (which is the list [10,11,20,21,30,31])
