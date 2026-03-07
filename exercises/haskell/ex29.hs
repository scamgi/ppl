{-
Exercise 29: Applicative for Maybe The Maybe a type (Just a | Nothing) is a perfect introduction to Applicative. Make it an instance of Applicative. pure should wrap a value in Just. What should happen if either the function or the value is Nothing?
-}

-- data Maybe a = Just a | Nothing

{-
instance Functor Maybe where
  fmap f (Just v) = Just (f v)
  fmap f Nothing = Nothing

instance Applicative Maybe where
  pure val = Just val
  (Just f) <*> (Just v) = Just (f v)

  -- Case 2: The function is Nothing, or the value is Nothing, or both.
  -- In any failure case, the result is Nothing. The wildcard `_` matches anything.
  _ <*> _ = Nothing
-}

main :: IO ()
main = do
  putStrLn "--- Part 1: The Basics ---"

  let maybeAddTen = Just (+10)
  let maybeNumber = Just 5
  let noFunction  = Nothing
  let noValue     = Nothing

  putStrLn "1. The 'Happy Path' (Just function, Just value):"
  print (maybeAddTen <*> maybeNumber)

  putStrLn "\n2. The 'Failure Paths' (when one or both are Nothing):"

  print ( (noFunction  <*> maybeNumber) :: Maybe Integer )
  print ( (maybeAddTen <*> noValue)     :: Maybe Integer )
  print ( (noFunction  <*> noValue)     :: Maybe Integer )


  putStrLn "\n--- Part 2: The Real Power - Working with Multi-Argument Functions ---"

  let add = (+)

  let resultSuccess = pure add <*> Just 3 <*> Just 4
  putStrLn "Applying a 2-argument function to two Just values:"
  print resultSuccess

  let resultFail = pure add <*> Just 3 <*> Nothing
  putStrLn "Applying it when one argument is Nothing:"
  print resultFail
