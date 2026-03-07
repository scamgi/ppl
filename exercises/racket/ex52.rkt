#lang racket

#|
Exercise 52: block-then (from PPL2022.01.21)

Description: Implement the block-then macro. (block <expr1> ... then <expr2> ... where (v <- a b) ...) should expand to create two lexical scopes. The first bindings a are for <expr1>, and the second bindings b are for <expr2>.
Learning Goal: Practice writing a macro that manages multiple, distinct code blocks and binding scopes.
|#

(define-syntax block
    (syntax-rules (then where <-)
        [(_ (expr-1 ...) then (expr-2 ...) where (v <- a b) ...)
            (begin
                (let ((v a) ...) expr-1 ...)
                (let ((v b) ...) expr-2 ...))]))

(block
    ((displayln (+ x y))
    (displayln (* x y))
    (displayln (* z z)))
then
    ((displayln (+ x y))
    (displayln (* z x)))
where (x <- 12 3)(y <- 8 7)(z <- 3 2))
