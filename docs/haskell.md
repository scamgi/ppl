# Haskell Cheatsheet

- Table of Contents
  {:toc}

## REPL

**REPL** stands for **Read-Eval-Print-Loop**. It is an interactive programming environment or shell where a user can type code, and the system immediately evaluates it and prints the result.

- **Scheme:** You can use the REPL to interactively test and evaluate expressions or syntactic forms, such as evaluating `+` and `if` directly at the prompt.
- **Haskell:** The REPL provides an interactive prompt (often displaying `Prelude>`, which is the standard library). Aside from evaluating expressions, you can use specific REPL commands like `:t` to find out the exact type of a function or expression.

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

### Dot Operator (`.`)

```haskell
let addOneAndDouble = (*2) . (+1)
addOneAndDouble 6 -- (6 + 1) * 2 = 14
```

### Dollar Operator (`$`)

```haskell
(10*) 5 + 3 -- will give an error, because haskell operates from left to right
(10*) (5 + 3) -- this is the first way on how to fix it
(10*) $ 5 + 3 -- this allows you do drop the parenthesis
```

## Basic Syntax

### Function Definition

```haskell
-- Function definition
add :: Int -> Int -> Int
add x y = x + y
```

### If-Then-Else

```haskell
-- if is an expression (always returns a value)
abs :: Int -> Int
abs n = if n < 0 then -n else n

-- Can be nested
signum :: Int -> Int
signum n = if n < 0 then -1 else if n > 0 then 1 else 0

-- Used inline
maxPlusOne x y = 1 + (if x > y then x else y)
```

### Let Expressions

```haskell
-- let ... in ... binds local variables within an expression
cylinderArea :: Float -> Float -> Float
cylinderArea r h =
    let sideArea = 2 * pi * r * h
        topArea = pi * r ^ 2
    in  sideArea + 2 * topArea

-- Multiple bindings
quadratic a b c x =
    let disc = b^2 - 4*a*c
        twoA = 2*a
    in  (-b + sqrt disc) / twoA

-- let can be used inline
result = let x = 5 in x * 2  -- 10
```

### Where Clauses

```haskell
-- where binds local variables after the expression
cylinderArea' :: Float -> Float -> Float
cylinderArea' r h = sideArea + 2 * topArea
    where sideArea = 2 * pi * r * h
          topArea = pi * r ^ 2

-- where works with guards
bmiTell :: Float -> Float -> String
bmiTell weight height
    | bmi <= 18.5 = "Underweight"
    | bmi <= 25.0 = "Normal"
    | bmi <= 30.0 = "Overweight"
    | otherwise   = "Obese"
    where bmi = weight / height ^ 2

-- Can define local functions
describeList :: [a] -> String
describeList xs = "The list is " ++ what xs
    where what [] = "empty"
          what [x] = "a singleton"
          what xs = "longer"
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
