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

## Conditionals

### cond

`cond` allows for multi-way branching. It evaluates a series of conditions and executes the body of the first true condition.

```racket
(define (classify-number n)
  (cond
    [(> n 0) 'positive]
    [(< n 0) 'negative]
    [else 'zero]))

(classify-number 5)  ; 'positive
(classify-number -2) ; 'negative
```

### case

`case` matches a value against a set of specific constants (using `eqv?`). It is useful when comparing a value against multiple options.

```racket
(define (classify-value v)
  (case v
    [(1 2 3) 'small]
    [(4 5 6) 'medium]
    [else 'large]))

(classify-value 2) ; 'small
(classify-value 5) ; 'medium
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

### Named let
`let` can be given a name to create a recursive loop.

```racket
(let loop ([n 10])
  (if (zero? n)
      'done
      (begin
        (display n)
        (loop (- n 1)))))
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

## Closures

A **closure** is a function that "closes over" the environment in which it was defined. It remembers the values of variables visible at definition time, even if those variables are no longer in scope when the function is called.

```racket
(define (make-adder x)
  (lambda (y) (+ x y))) ; Returns a closure that remembers 'x'

(define add5 (make-adder 5))
(add5 10) ; 15

;; Stateful Closure (using set!)
(define (iter-vector vec)
  (let ([cur 0]
        [top (vector-length vec)])
    (lambda ()
      (if (= cur top)
          '<<end>>
          (let ([v (vector-ref vec cur)])
            (set! cur (+ cur 1))
            v)))))

(define i (iter-vector #(1 2)))
(i) ; 1
(i) ; 2
(i) ; '<<end>>
```

## Tail Recursion

Racket optimizes **tail calls**. If the last expression in a function is a call to another function (or itself), the current stack frame is reused. This prevents stack overflow in recursive loops.

```racket
;; Tail Recursive Factorial
(define (factorial n acc)
  (if (zero? n)
      acc
      (factorial (- n 1) (* n acc)))) ; Tail call: result is directly returned

(factorial 5 1) ; 120

;; Non-Tail Recursive Factorial (causes stack buildup)
(define (factorial-bad n)
  (if (zero? n)
      1
      (* n (factorial-bad (- n 1))))) ; Multiplication happens AFTER the recursive call
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
-   `for-each`: Applies a function to each element of a list (for side effects).

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

;; for-each
(for-each (lambda (x) (display x)) '(1 2 3)) ; Prints 123
```

## Vectors

-   `vector`: Constructs a vector.
-   `vector-ref`: Gets an element.
-   `vector-set!`: Sets an element.
-   `vector-for-each`: Applies a function to each element of a vector (for side effects).

```racket
(define v (vector 10 20 30))
(vector-ref v 1) ; 20

;; vector-for-each
(vector-for-each (lambda (x) (display x)) #(1 2 3)) ; Prints 123
```

## Equivalence Predicates

-   `eq?`: Pointer equality. Checks if two objects refer to the exact same memory location. Fast, but fails for numbers or strings that look the same but are stored differently.
-   `eqv?`: Operational equivalence. Like `eq?`, but reliably compares numbers and characters.
-   `equal?`: Structural equality. Recursively checks if the contents of lists, vectors, strings, etc., are the same.

```racket
;; eq? - Identity
(define x '(1 2))
(define y '(1 2))

(eq? x y)       ; #f (different lists in memory)
(eq? x x)       ; #t
(eq? 'a 'a)     ; #t (symbols are unique/interned)

;; eqv? - Numbers and Characters
(eq? 1.0 1.0)   ; #f (unspecified behavior for some numbers)
(eqv? 1.0 1.0)  ; #t (reliably compares numbers)

;; equal? - Structure
(equal? x y)             ; #t (content is the same)
(equal? "hello" "hello") ; #t (strings with same chars)
(eq? "hello" "hello")    ; #f (different string objects)
```

## Mutability

Racket values are immutable by default (e.g., lists, symbols), but Racket provides mutable data structures and variables.

### Mutable Variables
`set!` is used to mutate the value of a variable defined with `define` or bound in a `let`.

```racket
(define x 10)
(set! x 20) ; x is now 20
```


### Mutable Vectors
Vectors are fixed-length mutable arrays.

```racket
(define v (vector 1 2 3))
(vector-set! v 0 99) ; v is now #(99 2 3)
```

## Call by Object Sharing

Racket uses **call by object sharing** (also known as "call by sharing").

-   Arguments are passed by value, but that value is a reference to the object.
-   If you **mutate** a mutable object (like a vector) passed as an argument, the change is visible outside the function.
-   If you **reassign** a variable (using `set!`) inside the function, it only changes the local binding and does *not* affect the variable passed by the caller.

```racket
(define (modify-vector v)
  (vector-set! v 0 99)) ; Mutation: Visible outside

(define (reassign-vector v)
  (set! v (vector 4 5 6))) ; Reassignment: Local only

(define vec (vector 1 2 3))

(modify-vector vec)
vec ; #(99 2 3) - The object was modified

(reassign-vector vec)
vec ; #(99 2 3) - The variable 'vec' still points to the same object
```

## Structs

Structs create new data types with named fields.

Defining a struct `(struct name (field1 ...))` automatically creates:
-   A constructor: `name`
-   A type predicate: `name?`
-   Field accessors: `name-field1`, `name-field2`...

By default, structs are immutable. Use `#:mutable` to allow field modification. This creates mutators like `set-name-field!`.

```racket
;; Define a mutable struct
(struct point (x y) #:mutable)

(define p (point 3 4))
(point? p)          ; #t
(point-x p)         ; 3

;; Mutate fields
(set-point-x! p 10)
(point-x p)         ; 10
(set-point-y! p 20)
(point-y p)         ; 20
```



