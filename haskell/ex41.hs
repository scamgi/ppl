{-
Exercise 41: Monad for a List with Length (Slist) (from 2021.08.31) Make the Slist a from Exercise 9 an instance of Monad. data Slist a = Slist Int [a] The challenge here is to correctly compute the length of the resulting Slist. Remember that xs >>= f applies f to each element and then joins the results. How do you combine the lengths of all the generated lists? Hint: you might need to convert back and forth from [a] using makeSlist.
-}

data Slist a = Slist Int [a] deriving Show

makeSlist :: [a] -> Slist a
makeSlist xs = Slist (length xs) xs

instance Functor Slist where
  fmap f (Slist a b) = Slist a (f b)

instance Applicative Slist where
  pure val = Slist 1 [val]

  (Slist a f) <*> (Slist b v) =
    