{-
Exercise 36: Applicative for a Three-Parameter Type (from 2024.07.03) Consider the datatype: data T x y z = T (x -> y -> z). Make T x y an instance of Applicative. Follow the types:

pure :: a -> T x y a
<*> :: T x y (a -> b) -> T x y a -> T x y b`
-}

data T x y z = T (x -> y -> z)

instance Functor (T x y) where
  fmap f (T a b c) = T a b (f c)

instance Applicative (T x y) where
  pure val = T x y val

  (T a b c) <*> (T a' b' c') = T a b (c c')

