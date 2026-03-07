-------------------------------------------------
-- 1. HELPER FUNCTIONS: Our failable operations
-------------------------------------------------

-- Safely gets the first element of a list.
-- Returns Nothing if the list is empty.
safeHead :: [a] -> Maybe a
safeHead []    = Nothing
safeHead (x:_) = Just x

-- Safely calculates the reciprocal of a number.
-- Returns Nothing if the input is 0, as 1/0 is undefined.
safeReciprocal :: Double -> Maybe Double
safeReciprocal 0.0 = Nothing
safeReciprocal n   = Just (1.0 / n)


-----------------------------------------------------------
-- 2. THE "UGLY" WAY: Manually checking for failure
-----------------------------------------------------------

-- This function chains the two failable operations by nesting 'case'
-- statements. This is verbose and becomes hard to manage with more steps.
calculateReciprocalOfHead_ugly :: [Double] -> Maybe Double
calculateReciprocalOfHead_ugly list =
  -- First, try to get the head of the list.
  case safeHead list of
    -- If it failed, we're done. The whole thing is a failure.
    Nothing -> Nothing
    -- If it succeeded, we get 'headValue' and can proceed to the next step.
    Just headValue ->
      -- Now, try to get the reciprocal of the head value.
      case safeReciprocal headValue of
        -- If THIS step failed, the whole thing is a failure.
        Nothing -> Nothing
        -- If it succeeded, we finally have our result!
        Just reciprocalValue -> Just reciprocalValue


----------------------------------------------------------------
-- 3. THE MONADIC WAY: Using the power of 'Maybe' as a Monad
----------------------------------------------------------------

-- This version uses 'do' notation, which is syntactic sugar for the
-- Monad's '>>=' (bind) operator. It's clean, flat, and easy to read.
calculateReciprocalOfHead_do :: [Double] -> Maybe Double
calculateReciprocalOfHead_do list = do
  -- The '<-' arrow performs the operation on the right.
  -- If the result is 'Nothing', the entire 'do' block stops immediately.
  -- If the result is 'Just x', it unwraps 'x' and assigns it to 'headValue'.
  headValue <- safeHead list

  -- This line is only ever reached if 'safeHead' succeeded.
  -- The result of the last line is the result of the whole 'do' block.
  safeReciprocal headValue

-- Note: The version with the '>>=' operator looks like this and is equivalent:
-- calculateReciprocalOfHead_bind :: [Double] -> Maybe Double
-- calculateReciprocalOfHead_bind list = safeHead list >>= safeReciprocal


----------------------------------------------------------------
-- 4. MAIN FUNCTION: Running the examples
----------------------------------------------------------------

main :: IO ()
main = do
  putStrLn "Welcome to the Maybe Monad example!"

  -- Case 1: Everything succeeds
  putStrLn "\n--- Success Case: Input is [2.0, 4.0] ---"
  putStr "Ugly version result:    "
  print (calculateReciprocalOfHead_ugly [2.0, 4.0])
  putStr "Monadic version result: "
  print (calculateReciprocalOfHead_do [2.0, 4.0])

  -- Case 2: The first step fails (empty list)
  putStrLn "\n--- First Step Fails: Input is [] ---"
  putStr "Ugly version result:    "
  print (calculateReciprocalOfHead_ugly [])
  putStr "Monadic version result: "
  print (calculateReciprocalOfHead_do [])

  -- Case 3: The second step fails (head is 0)
  putStrLn "\n--- Second Step Fails: Input is [0.0, 5.0] ---"
  putStr "Ugly version result:    "
  print (calculateReciprocalOfHead_ugly [0.0, 5.0])
  putStr "Monadic version result: "
  print (calculateReciprocalOfHead_do [0.0, 5.0])
