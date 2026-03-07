#lang racket

#|
Exercise 23: Memoization

Description: Write a higher-order function memoize that takes a procedure proc (of one argument) and returns a memoized version of it. The memoized version should store results in a hash table to avoid re-computation for the same input.
E.g.: (define slow-fib ...) (define fast-fib (memoize slow-fib)) (fast-fib 40) should be much faster on the second call.
Learning Goal: Use state to implement a powerful optimization technique.
|#

(define (memoize func)
  ; first it creates a new hask table
  (let ((returns (make-hash)))
       (lambda (x)
          (cond
            ; first it checks if the x is inside the hash table. If it is inside, it returns the stored value
            [(hash-has-key? returns x) (hash-ref returns x)]
            
            ; if it has no key, it creates the new key
            [else (let ((y (func x)))
              ; I set the new reference
              (hash-set! returns x y)
              ; I return the value
              y)]))))

(define fast-add1 (memoize add1))
(fast-add1 1)
(fast-add1 1) ; this is the stored one
(fast-add1 2)
(fast-add1 2) ; this is the stored one
