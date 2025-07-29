#lang racket

#|
Exercise 16: Function Composition

Description: Write a function compose that takes two functions, f and g, and returns a new function that represents their composition, f(g(x)).
E.g.: (define (add1 x) (+ x 1)) (define (sqr x) (* x x)) ((compose sqr add1) 5) should return 36.
Learning Goal: Practice creating functions that return other functions (closures), a key concept.
|#

(define (compose f g)
  (lambda (x) (f (g x))))

