-- solution from the professor

hamming :: [Integer]
hamming = 1 : merge (map (2*) hamming) (merge (map (3*) hamming) (map (5*) hamming))

merge :: [Integer] -> [Integer] -> [Integer]
merge (x:xs) (y:ys)
  | x < y     = x : merge xs (y:ys)
  | x > y     = y : merge (x:xs) ys
  | otherwise = x : merge xs ys

