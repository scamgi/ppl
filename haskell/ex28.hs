{-
Exercise 28: A Foldable Tree with Node Counts (from 2022.09.01) Consider the data type: data Ctree a = Cnil | Ctree a Int (Ctree a) (Ctree a) Make this data structure an instance of Foldable. The Int value represents a count and should not be included in the fold.
-}

data Ctree a = Cnil | Ctree a Int (Ctree a) (Ctree a)

instance Foldable Ctree where
  foldr f z (Cnil) = z
  foldr f z (Ctree value i left right) = foldr f (f value (foldr f z right)) left

