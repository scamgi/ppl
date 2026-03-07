# Racket Cheatsheet

- Table of Contents
  {:toc}

## S-Expressions

S-expressions (symbolic expressions) are the fundamental building blocks of Racket code and data. An S-expression is either an **atom** or a **list**.

*   **Atoms**: Basic values like numbers, symbols, booleans, strings, and characters.
*   **Lists**: A sequence of S-expressions enclosed in parentheses `( ... )`.

Examples:

```racket
;; Atoms
42              ; Number
'foo            ; Symbol
#t              ; Boolean
"hello"         ; String
#\c             ; Character

;; Data Structures
'(1 . 2)        ; Pair (dotted pair)
#(1 2 3)        ; Vector


;; Lists
(+ 1 2)         ; A list representing a function call
'(1 2 3)        ; A list of numbers (quoted data)
(list 1 2 3)    ; A function call constructing a list
(= x (+ y (* 3 x ) z )) ; A nested S-expression
```

## Basic Syntax
