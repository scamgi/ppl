#lang racket

#|
Exercise 51: let** (from PPL2023.07.03)

Description: Implement the let** macro. It behaves like let*, but if a variable is given without a value, it inherits the value of the most recently defined variable. A def: keyword provides a default for the very first variable.
Learning Goal: Write a recursive macro that peels off one binding at a time and passes the "state" (the last value) into the expansion of the rest of the macro.
|#

(define-syntax let**
    (syntax-rules (def:)
        [(_ ((var val) ...) body ...)
            ()]
        [(_ ((def: val-0) (var val) ...) body ...)
            ()]))