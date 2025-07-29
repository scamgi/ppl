{-
Exercise 12: Comparing Shapes Make the Shape type from Exercise 3 an instance of Eq. Two shapes are equal if they are the same type of shape and have the same dimensions.
-}

{-
data Shape = Circle (Float radius) | Rectangle (Float width) (Float height)

instance Eq Shape where
  (Circle {radius = r1}) == (Circle {radius = r2}) = r1 == r2
  (Rectangle {width = w1, height = h1}) == (Rectangle {width = w2, height = h2}) = w1 == w2 && r1 == r2
-}


data Shape = Circle Float | Rectangle Float Float deriving Show

instance Eq Shape where
  (Circle r1) == (Circle r2) = r1 == r2
  (Rectangle w1 h1) == (Rectangle w2 h2) = (w1 == w2) && (h1 == h2)
  _ == _ = False
