{-
Exercise 18: The Fpair Functor (from 2022.06.16) Consider the data type Fpair s a, which can be Fpair a a s or Pair a a. Make it an instance of Functor with respect to the type a.
-}

data Fpair s a = Fpair a a s | Pair a a deriving Show

-- some mistakes
{-
instance Functor Fpair where
  fmap f (Fpair a b c) = Fpair (f a) (f b) (f c)
  fmap f (Pair a b) = Pair (f a) (f b)
-}

-- first, fmap works with one type only, so I need to fix a type if there are two types.
-- In this case, the exercise asks to fix s

instance Functor (Fpair s) where
  fmap f (Fpair a b c) = Fpair (f a) (f b) c
  fmap f (Pair a b) = Pair (f a) (f b)

main :: IO ()
main = do
  putStrLn "--- Testing the Functor for Fpair s a ---"
  
  -- No change here, type is inferred correctly.
  let fpair_val = Fpair 10 20 "this is s"
  
  -- THE FIX: Add a type annotation to resolve the ambiguity.
  let pair_val :: Fpair String Int
      pair_val = Pair 100 200

  putStrLn ("Original Fpair value: " ++ show fpair_val)
  putStrLn ("Original Pair value:  " ++ show pair_val)
  putStrLn ""

  let addFive = (+5)
  putStrLn "Applying `fmap (+5)` to both..."

  let result1 = fmap addFive fpair_val
  
  -- We also need to annotate the result, as it has the same ambiguity!
  let result2 :: Fpair String Int
      result2 = fmap addFive pair_val

  putStrLn ("New Fpair value: " ++ show result1)
  putStrLn ("New Pair value:  " ++ show result2)
  putStrLn ""
  putStrLn "Notice how the string 'this is s' was correctly left untouched!"

