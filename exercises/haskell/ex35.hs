{-
Exercise 35: Applicative for Fpair (from 2022.06.16) Make the Fpair s a from Exercise 18 an instance of Applicative. You will need to define how <*> behaves for all combinations of the Fpair and Pair constructors.
-}

data Fpair s a = Fpair a a s | Pair a a deriving Show

instance Functor (Fpair s) where
  fmap f (Fpair v1 v2 s_val) = Fpair (f v1) (f v2) s_val
  fmap f (Pair v1 v2) = Pair (f v1) (f v2)

instance Applicative (Fpair s) where
  pure val = Pair val val

  (Fpair f1 f2 s) <*> (Fpair v1 v2 s') =
    Fpair (f1 v1) (f2 v2) s
  
  (Fpair f1 f2 s) <*> (Pair v1 v2) =
    Fpair (f1 v1) (f2 v2) s
  
  (Pair f1 f2) <*> (Fpair v1 v2 s) =
    Fpair (f1 v1) (f2 v2) s
  
  (Pair f1 f2) <*> (Pair v1 v2) =
    Pair (f1 v1) (f2 v2)
