{-
Exercise 19: The Expr Functor (from 2024.01.11 & 2024.02.02) Given the following data type for an expression: data Expr a = Var a | Const Int | Op (Expr a) (Expr a) Make it an instance of Functor. The function should only be applied to the Var constructors.
-}

-- Your data definition and Functor instance are PERFECT and stay the same.
data Expr a = Var a | Const Int | Op (Expr a) (Expr a) deriving Show

instance Functor Expr where
  fmap f (Var v) = Var (f v)
  fmap _ (Const v) = Const v
  fmap f (Op l r) = Op (fmap f l) (fmap f r)

main = do
  -- 1. Use more descriptive names to avoid clashes with standard functions.
  let varExpr = Var 10
  
  -- 2. Add a type annotation to resolve the ambiguity for the Const constructor.
  let constExpr :: Expr Int
      constExpr = Const 2
      
  let opExpr = Op varExpr constExpr

  let addFive = (+5)

  let varFMap = fmap addFive varExpr
  let constFMap = fmap addFive constExpr
  let opFMap = fmap addFive opExpr

  putStrLn "--- Variable ---"
  putStrLn ("Original: " ++ show varExpr)
  putStrLn ("fmap:     " ++ show varFMap)
  putStrLn ""

  putStrLn "--- Constant ---"
  putStrLn ("Original: " ++ show constExpr)
  putStrLn ("fmap:     " ++ show constFMap)
  putStrLn ""
  
  putStrLn "--- Operator ---"
  putStrLn ("Original: " ++ show opExpr)
  putStrLn ("fmap:     " ++ show opFMap)

