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

;; Modifying Code
(define modified-snippet (cons '* (cdr code-snippet))) ; Change + to *
(eval modified-snippet)        ; Evaluated as code: (* 1 2) -> 2
```

## Syntactic Forms

Syntactic forms (or special forms) are expressions that have special evaluation rules, unlike function calls where all arguments are evaluated first.

Common syntactic forms:
-   `define`: Binds a value to a name.
-   `lambda`: Creates a procedure.
-   `if`: Conditionally evaluates expressions (short-circuiting).
-   `quote` (or `'`): Prevents evaluation of its argument.
-   `let`, `let*`, `letrec`: Local bindings.
-   `cond`, `and`, `or`: Conditional control flow.
-   `begin`: Sequences multiple expressions.
-   `set!`: Mutates an existing variable.

```racket
;; 'if' is a syntactic form because it only evaluates one branch
(if #t 1 (/ 1 0)) ; Returns 1, division by zero is never evaluated

;; 'define' binds a value or defines a function
(define x 10)
(define (square x) (* x x))

;; 'set!' changes the value of an existing variable
(set! x 20) ; x is now 20

;; 'begin' evaluates expressions in order and returns the last result
(begin
  (display "First\n")
  (display "Second\n")
  (+ 1 2)) ; Returns 3
```

## Quoting

Quoting prevents evaluation of an expression, treating it as data (symbols or lists) instead of code.

-   `quote` or `'`: Standard quoting.
-   `quasiquote` or `` ` ``: Allows unquoting parts of the expression.
-   `unquote` or `,`: Evaluates the expression inside a quasiquote.
-   `unquote-splicing` or `,@`: Evaluates and splices the list into the surrounding list.

```racket
;; Quote
'(+ 1 2)         ; Evaluates to the list (+ 1 2), not 3
(quote (+ 1 2))  ; Same as above

;; Quasiquote and Unquote
(define x 10)
`(+ x ,x)        ; Evaluates to the list (+ x 10)
`(+ x ,(+ x 5))  ; Evaluates to the list (+ x 15)

;; Unquote Splicing
(define lst '(1 2 3))
`(0 ,@lst 4)     ; Evaluates to (0 1 2 3 4)
`(0 ,lst 4)      ; Evaluates to (0 (1 2 3) 4)
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

## Pairs and Lists

Lists in Racket are linked lists built from **pairs** (cons cells).

-   `cons`: Constructs a pair.
-   `car` (or `first`): Gets the first element (head).
-   `cdr` (or `rest`): Gets the second element (tail).
-   `list`: Constructs a list.
-   `null?` (or `empty?`): Checks for an empty list.
-   `member`: Checks if an element is in a list (returns the tail starting with the element or #f).
-   `apply`: Applies a function to a list of arguments.

```racket
;; Pairs
(cons 1 2)        ; '(1 . 2) - A dotted pair
(car (cons 1 2))  ; 1
(cdr (cons 1 2))  ; 2

;; Lists (proper lists end with null)
(cons 1 (cons 2 '())) ; '(1 2)
(list 1 2 3)          ; '(1 2 3)

;; List Operations
(first '(1 2 3))      ; 1
(rest '(1 2 3))       ; '(2 3)
(car '(1 2 3))        ; 1
(cdr '(1 2 3))        ; '(2 3)
(null? '())           ; #t
(member 2 '(1 2 3))   ; '(2 3)
(member 4 '(1 2 3))   ; #f

;; Apply
(apply + '(1 2 3))    ; 6 (equivalent to (+ 1 2 3))
```
