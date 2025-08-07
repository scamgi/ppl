#lang racket

#|
Exercise 40: Basic For Loop Macro (without named let or letrec)

Description: Implement the iteration part of the For loop from PPL2023.02.15.
This version expands into a recursive loop using a self-passing lambda.
|#

(define-syntax for
  (syntax-rules (from to do)
    [(_ i from start to end do body ...)
     (let loop ([i start]) ; Use a named let. 'i' is both the loop variable and the name used in the body.
       (when (<= i end)     ; 1. The condition is now correct.
         body ...           ; 2. 'i' is correctly bound to the current loop value here.
         (loop (+ i 1))))])) ; Recurse by calling the named let.

