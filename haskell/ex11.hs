{-
Exercise 11: Custom Show for a Book Make the Book type from Exercise 2 an instance of Show. For a book with title "Moby Dick" and publication year 1851, the output of show should be "Moby Dick (1851)".
-}

data Book = Book { title :: String , year :: Int }

instance Show Book where
  show (Book {title = t, year = y}) = t ++ " (" ++ show y ++ ")"

main = do
  let mobyDick = Book { title = "Moby Dick", year = 1851 }
  putStrLn (show mobyDick)
