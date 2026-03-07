#lang racket

#|
Exercise 17: list-to-compose (from PPL2022.06.16)

Description: Define a pure function list-to-compose which takes a list of functions and returns their composition.
E.g.: ((list-to-compose (list sqr add1)) 5) should return 36.
Learning Goal: Combine fold with function composition to solve a real exam problem elegantly.
|#

(define (list-to-compose functions)
  (define (helper rest)
    (cond
      [(empty? rest) (lambda (x) (x))]
      
      [else (lambda (x) ((car rest) (helper (cdr rest))))])))

