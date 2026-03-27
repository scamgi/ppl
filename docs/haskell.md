# Haskell Cheatsheet

* Table of Contents
{:toc}

## Types

```haskell
5 :: Integer
'a' :: Char
inc :: Integer -> Integer
[1, 2, 3] :: [Integer]  -- equivalent to 1:(2:(3:[]))
('b', 4) :: (Char, Integer)
"hello" :: [Char]       -- strings are lists of characters
```

## Operators

### List Concatenation (++)
```haskell
(++) :: [a] -> [a] -> [a]

[1, 2] ++ [3, 4]      -- [1, 2, 3, 4]
"Hello" ++ " World"   -- "Hello World"
[] ++ [1, 2]          -- [1, 2]
```

## Basic Syntax

### Function Definition
```haskell
-- Function definition
add :: Int -> Int -> Int
add x y = x + y
```

## Pattern Matching

Pattern matching allows you to deconstruct data structures and bind variables to their components.

### On Function Arguments
```haskell
-- Match on literal values
isZero :: Integer -> Bool
isZero 0 = True
isZero _ = False  -- underscore matches anything (wildcard)

-- Match on list structure
head :: [a] -> a
head (x:_) = x  -- x binds to first element, _ ignores the rest

tail :: [a] -> [a]
tail (_:xs) = xs  -- xs binds to the rest of the list

isEmpty :: [a] -> Bool
isEmpty [] = True
isEmpty _  = False
```

### On Tuples
```haskell
fst :: (a, b) -> a
fst (x, _) = x

snd :: (a, b) -> b
snd (_, y) = y

addPair :: (Int, Int) -> Int
addPair (x, y) = x + y
```

### With Case Expressions
```haskell
describe :: [a] -> String
describe xs = case xs of
    []      -> "empty"
    [x]     -> "singleton"
    [x, y]  -> "pair"
    _       -> "longer list"
```

### With Guards
```haskell
absolute :: Int -> Int
absolute n
    | n < 0     = -n
    | otherwise = n

grade :: Int -> String
grade score
    | score >= 90 = "A"
    | score >= 80 = "B"
    | score >= 70 = "C"
    | otherwise   = "F"
```
