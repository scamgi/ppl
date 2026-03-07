#lang racket

#|
Exercise 53: An unless Macro

Description: Write a macro unless that is the inverse of if. (unless <condition> <then-expr> <else-expr>) should execute <then-expr> if the condition is false, and <else-expr> if it is true.
Learning Goal: A straightforward but essential exercise to solidify your understanding of how macros re-arrange syntax into existing forms (if).
|#

(define-syntax unless
    (syntax-rules ()
        [(_ condition then-expr else-expr)
            (if condition
                else-expr
                then-expr)]))

