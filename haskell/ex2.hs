{-
Exercise 2: Data Types with Fields Define a data type Book which has a String field for the title and an Int field for the year of publication. Use the record syntax for this.
-}

data Book = Book { title :: String, year :: Int } deriving (Show)


printBookDetails :: Book -> IO ()
printBookDetails b = do
  putStrLn ("Title: " ++ title b)
  putStrLn ("Year of Publication: " ++ show (year b))


main :: IO ()
main = do
  let mobyDick = Book { title = "Moby Dick", year = 1851 }
  let theHobbit = Book { title = "The Hobbit", year = 1937 }

  putStrLn "--- Printing the full records ---"
  print mobyDick
  print theHobbit
  putStrLn ""

  putStrLn "--- Printing with our custom function ---"
  printBookDetails mobyDick
  putStrLn "" 
  printBookDetails theHobbit

  -- You can also access a single field directly.
  putStrLn "--- Accessing a single field ---"
  putStrLn ("The title of the first book is: " ++ title mobyDick)
