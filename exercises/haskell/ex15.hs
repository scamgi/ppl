{-
Exercise 15: Showing a Gtree Make the Gtree a from Exercise 7 an instance of Show. Try to format it in a way that is readable, for example, by indenting children.
-}

data Gtree a = Gtree a [Gtree a]

instance (Show a) => Show (Gtree a) where
  show (Gtree a [b]) = (show a) ++ "\n  " ++ (show b)

main = do
  let gt = Gtree 1 [Gtree 2 [], Gtree 3 [], Gtree 4 [Gtree 5 [], Gtree 6 []]]
  putStrLn (show gt)
