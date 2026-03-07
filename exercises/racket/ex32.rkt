#lang racket

#|
Exercise 32: product-with-zero

Description: Write a function that computes the product of a list of numbers. If it ever encounters a 0, it should immediately return 0 without multiplying by any subsequent numbers.
Learning Goal: Reinforce the call/cc pattern for early exit based on a specific value.
|#

(define (product-with-zero . args)
  (call/cc
    (lambda (exit)
      (define (loop lst acc)
        (cond
          ; base case
          [(empty? lst) acc]
          
          ; case 2: zero
          [(= (car lst) 0) (exit 0)]
          
          ; case 3: I iterate
          [else (loop (cdr lst) (* acc (car lst)))]))
      (loop args 1))))

; examples

(product-with-zero 1 2 3) ; should return 6
(product-with-zero 1 (- 0 2) 3) ; should return -6
(product-with-zero 1 0 2 3) ; should return 0
