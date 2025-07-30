#lang racket

#|
Exercise 21: A Simple Counter

Description: Write a function make-counter that takes no arguments and returns a procedure. Each time the returned procedure is called, it should return a number that is one greater than the last time it was called. The first call should return 1.
E.g.: (define c1 (make-counter)) (c1) → 1, (c1) → 2. (define c2 (make-counter)) (c2) → 1.
Learning Goal: Understand the core pattern of a closure: a lambda that captures and modifies a variable from its lexical environment using set!.
|#

(define (make-counter)
  (let ((x 0))
    (lambda ()
      ; first I set the variable
      (set! x (+ x 1))
      ; then I return the variable
      x)))

; examples

(define c1 (make-counter))
(c1) ; should return 1
(c1) ; should return 2
(c1) ; should return 3

(define c2 (make-counter))
(c2) ; should return 1
(c1) ; should return 4
(c2) ; should return 2
(c1) ; should return 5
(c2) ; should return 3
