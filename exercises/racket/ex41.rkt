#lang racket

#|
Exercise 41: Tail-Recursive Factorial

Description: Rewrite the classic factorial function to be tail-recursive. This requires a helper function that uses an accumulator to pass the intermediate result forward.
E.g.: (tr-factorial 5) should return 120 without growing the stack for each recursive call.
Learning Goal: Master the fundamental accumulator pattern for converting a simple recursion into a tail-recursive one.
|#

(define (tr-factorial x)
  (define (trf-helper n acc)
    (if (= n 0)
      acc
      (trf-helper (- n 1) (* acc n)))
  (trf-helper x 1)))

