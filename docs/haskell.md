# Haskell Cheatsheet

- Table of Contents
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

## Infinite Computations

Haskell's lazy evaluation allows working with infinite data structures. Values are only computed when needed.

### Infinite Lists

```haskell
-- Infinite list of ones
ones :: [Integer]
ones = 1 : ones  -- [1, 1, 1, 1, ...]

-- Natural numbers
nats :: [Integer]
nats = 0 : map (+1) nats  -- [0, 1, 2, 3, ...]

-- Using enumeration syntax
[1..]       -- [1, 2, 3, 4, ...]  infinite list starting at 1
[1,3..]     -- [1, 3, 5, 7, ...]  infinite odd numbers
```

### Working with Infinite Lists

```haskell
-- Take first n elements
take 5 [1..]           -- [1, 2, 3, 4, 5]
take 3 (repeat 'a')    -- "aaa"

-- Drop first n elements (still infinite)
drop 5 [1..]           -- [6, 7, 8, ...]

-- Take while predicate holds
takeWhile (<5) [1..]   -- [1, 2, 3, 4]

-- Fibonacci sequence
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
-- [0, 1, 1, 2, 3, 5, 8, 13, ...]

take 10 fibs           -- [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
```

### Why It Works: Lazy Evaluation

```haskell
-- Only computes what's needed
head [1..]             -- 1 (doesn't evaluate the whole list)
take 3 (map (*2) [1..])  -- [2, 4, 6] (only maps first 3 elements)

-- Be careful: these will never terminate!
-- length [1..]        -- infinite loop
-- sum [1..]           -- infinite loop
```
