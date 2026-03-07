{-
Exercise 3: A Sum Type with Data Define a data type Shape which can be either a Circle with a Float radius or a Rectangle with two Float fields for width and height.
-}

data Shape = Circle (Float radius) | Rectangle (Float width) (Float height)
