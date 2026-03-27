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

## Basic Syntax

### Function Definition
```haskell
-- Function definition
add :: Int -> Int -> Int
add x y = x + y
```
