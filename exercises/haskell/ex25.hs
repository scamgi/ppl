{-
Exercise 25: A Foldable "Fancy Pair" (from 2022.06.16) Make the Fpair s a from Exercise 18 an instance of Foldable. The implementation should fold over the two values of type a.
-}

data Fpair s a = Fpair a a s | Pair a a deriving Show

instance Foldable (Fpair s) where
  foldr f z (Fpair l c r) = f l (f c z)
  foldr f z (Pair l r) = f l (f r z)
