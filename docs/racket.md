# Racket Cheatsheet

- Table of Contents
  {:toc}

## S-Expressions

S-expressions (symbolic expressions) are the fundamental building blocks of Racket code and data. An S-expression is either an **atom** or a **list**.

- **Atoms**: Basic values like numbers, symbols, booleans, strings, and characters.
- **Lists**: A sequence of S-expressions enclosed in parentheses `( ... )`.

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

## Homoiconicity

Racket is **homoiconic**, meaning "same representation". The code structure (S-expressions) is the same as the data structure. This allows code to be treated as data and manipulated programmatically (macros).

```racket
;; Code as Data
(define code-snippet '(+ 1 2)) ; A list of data: (+ 1 2)
(eval code-snippet)            ; Evaluated as code: 3
```

## Lambdas

Lambdas are anonymous functions.

```racket
(lambda (x y) ; this is a comment
  (+ (* x x) (* y y)))
```

## Local Bindings (let, let*, letrec)

### let
`let` allows you to bind variables locally. Bindings are evaluated in parallel (variables in the same `let` cannot refer to each other).

```racket
(let ([x 2]
      [y 3])
  (+ x y)) ; Returns 5
```

### let*
`let*` evaluates bindings sequentially. Later bindings can use earlier ones.

```racket
(let* ([x 2]
       [y (+ x 1)])
  (+ x y)) ; Returns 5
```

### letrec
`letrec` allows recursive bindings (bindings can refer to each other), useful for defining recursive local functions.

```racket
(letrec ([is-even? (lambda (n)
                     (if (zero? n)
                         #t
                         (is-odd? (- n 1))))]
         [is-odd? (lambda (n)
                    (if (zero? n)
                        #f
                        (is-even? (- n 1))))])
  (is-even? 10)) ; Returns #t
```

## Scoping

Racket uses **lexical scoping** (static scoping) by default. This means a function's environment is determined by where it is defined, not where it is called.

```racket
;; Lexical Scoping (Default)
(define x 10)
(define (f) x)

(let ([x 20])
  (f)) ; Returns 10 (uses global x from definition site)
```

## Basic Syntax

### Function Definition

```racket
;; Function definition
(define (add x y)
  (+ x y))
```
