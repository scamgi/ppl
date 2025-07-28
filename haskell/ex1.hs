{-
Exercise 1: A Basic Enumeration Define a data type TrafficLight that can have one of three values: Red, Amber, or Green.
-}

data TrafficLight = Red | Amber | Green deriving (Show)

-- The main action for our program
main :: IO ()
main = do
  let myLight = Green
  print myLight -- print will display the value in the console
