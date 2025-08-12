{-
Exercise 42: A State-and-Maybe Monad (F) (from 2024.02.02) This is a challenging but insightful problem. Consider the datatype: data F b a = F (b -> b) a | Null Make F b an instance of Monad.

pure :: a -> F b a
>>= :: F b a -> (a -> F b c) -> F b c Think of this as a computation that might fail (Null) or might succeed with a value (a) and a function to update some state (b -> b). The monadic bind >>= should chain these computations, composing the state-updating functions.
-}

data F b a = F (b -> b) a | Null

instance Functor (F b) where
  fmap f (F x y) = F x (f y)
  fmap f Null = Null

instance Applicative (F b) where
  pure val = F (_ -> val) val

  (F a f) <*> (F b v) =
    F a (f v)
  
  _ <*> _ = Null

instance Monad (F b) where
  Null >>= f =
    Null

  F b v >>= f =
    f v
