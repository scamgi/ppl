data Shape = Circle Float | Rectangle Float Float deriving (Show)

area :: Shape -> Float
area (Circle r) = pi * r * r
area (Rectangle w h) = w * h

main :: IO ()
main = do
  let myCircle = Circle 10.0
  let myRectangle = Rectangle 20.0 10.0

  print (area myCircle)
  print (area myRectangle)