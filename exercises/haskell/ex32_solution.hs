data Expr a = Var a | Const Int | Op (Expr a) (Expr a) deriving Show

instance Functor Expr where
  fmap f (Var v) = Var (f v)
  fmap _ (Const v) = Const v
  fmap f (Op l r) = Op (fmap f l) (fmap f r)

instance Applicative Expr where
  pure = Var

  -- A constant on the function side cannot be applied.
  -- We must cast its type to satisfy the compiler.
  (Const c) <*> _ = Const c

  -- If the function is just a Var, apply it to the entire second expression.
  (Var f)   <*> x = fmap f x

  -- If the function is an Op, distribute the application.
  (Op f g)  <*> x = Op (f <*> x) (g <*> x)

-- Main function to demonstrate
main :: IO ()
main = do
  -- f is an expression containing two functions: (+1) and (*10)
  let f = Op (Var (+1)) (Var (*10))
  -- x is an expression containing two values: 5 and a constant 100
  let x = Op (Var 5) (Const 100)

  putStrLn "Applying an expression of functions to an expression of values:"
  -- The application is distributed:
  -- Op ((Var (+1)) <*> x)  ((Var (*10)) <*> x)
  -- The left side becomes: fmap (+1) x -> Op (Var 6) (Const 100)
  -- The right side becomes: fmap (*10) x -> Op (Var 50) (Const 100)
  -- Final result is these two combined with Op.
  let result = f <*> x
  print result
  -- Expected: Op (Op (Var 6) (Const 100)) (Op (Var 50) (Const 100))

