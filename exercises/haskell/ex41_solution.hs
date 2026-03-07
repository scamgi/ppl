{-
Exercise 41: Monad for a List with Length (Slist) (from 2021.08.31)
Make the Slist a from Exercise 9 an instance of Monad.
-}

-- The data structure and smart constructor
data Slist a = Slist Int [a] deriving Show

makeSlist :: [a] -> Slist a
makeSlist xs = Slist (length xs) xs

-- The Functor instance maps the function over the contained list.
instance Functor Slist where
  fmap f (Slist len xs) = Slist len (map f xs)

-- The Applicative instance uses the list's Applicative and calculates the new length.
instance Applicative Slist where
  pure val = Slist 1 [val]

  -- The length of the new list is the product of the lengths of the two source lists.
  (Slist lenF fs) <*> (Slist lenV vs) = makeSlist (fs <*> vs)


-- The Monad instance
instance Monad Slist where
  -- The return function is the same as pure.
  return = pure

  -- Bind (>>=) applies a function to each element and concatenates the results.
  (Slist _ xs) >>= f =
    -- 1. Apply f to each element of the list `xs`. This produces a list of Slist b.
    --    Example: map f [1,2] might produce [Slist 2 [10,11], Slist 2 [20,21]]
    let listOfSlists = map f xs

    -- 2. Extract the inner list from each Slist in listOfSlists.
    --    Example: [[10,11], [20,21]]
        innerLists = map (\(Slist _ l) -> l) listOfSlists

    -- 3. Concatenate all inner lists and use makeSlist to build the final result.
    --    `makeSlist` automatically computes the correct total length.
    --    Example: makeSlist [10,11,20,21] -> Slist 4 [10,11,20,21]
    in makeSlist (concat innerLists)

