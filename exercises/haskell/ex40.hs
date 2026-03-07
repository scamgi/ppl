{-
Exercise 40: Monad for the Expr type (from 2024.01.11 & 2024.02.02) Make the Expr a from Exercise 19 an instance of Monad. >>= takes an expression and a function f that transforms a value a into a new Expr b. The f function should be applied wherever a Var a appears, effectively substituting a variable with a whole new expression.
-}

data Expr a = Var a | Const Int | Op (Expr a) (Expr a) deriving Show

instance Functor Expr where
  fmap f (Var val) = Var (f val)
  fmap f (Const val) = Const val
  fmap f (Op left right) = Op (fmap f left) (fmap f right)

instance Applicative Expr where
  pure val = Var val

  _ <*> (Const val) = Const val

  (Var f) <*> (Var v) = Var (f v)
  (Const f) <*> (Var v) = Var (f v)
  (Op f1 f2) <*> (Op v1 v2) = Op (f1 v1) (f2 v2)
  (Op f1 f2) <*> (Var val) = Op (Var (f1 val)) (Var (f2 val))
  (Var f) <*> (Op v1 v2) = Op (f v1) (f v2)

instance Monad Expr where
  -- The bind operator: (>>=) :: Expr a -> (a -> Expr b) -> Expr b
  
  -- Case 1: If the expression is a variable (Var a), apply the function `f` to `a`.
  -- The function `f` takes the value `a` and returns a whole new expression of type `Expr b`.
  -- This is the core substitution step.
  (Var a) >>= f = f a

  -- Case 2: If the expression is a constant (Const i), there's no `a` value to apply `f` to.
  -- So, we just return the constant value unchanged. The result is still of type `Expr b`.
  (Const i) >>= f = Const i

  -- Case 3: If the expression is an operation, we must recursively apply the substitution
  -- to both the left and right sub-expressions.
  -- `(l >>= f)` performs the substitution on the left side.
  -- `(r >>= f)` performs the substitution on the right side.
  -- We then build a new `Op` with the transformed sub-expressions.
  (Op l r) >>= f = Op (l >>= f) (r >>= f)

