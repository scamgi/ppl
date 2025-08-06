{-
Exercise 32: Applicative for Expr (from 2024.01.11 & 2024.02.02) Make the Expr a from Exercise 19 an instance of Applicative. You will need to decide on a sensible implementation for what Op f g <*> x means. The exam solution provides one possible interpretation.
-}

data Expr a = Var a | Const Int | Op (Expr a) (Expr a) deriving Show

instance Functor Expr where
  fmap f (Var v) = Var (f v)
  fmap _ (Const v) = Const v
  fmap f (Op l r) = Op (fmap f l) (fmap f r)

instance Applicative Expr where
  pure val = Var val

  (Op f g) <*> (x) = f (g x)

