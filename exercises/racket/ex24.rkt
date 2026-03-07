#lang racket

#|
Exercise 24: A Stateful Generator (from PPL2022.02.10)

Description: Implement the r function from the exam. It should be a generator that returns numbers from a starting value x to an upper limit y with a given step s. When y is reached, it should return y indefinitely.
E.g.: (define g (r 10 16 2)) (g) → 10, (g) → 12, (g) → 14, (g) → 16, (g) → 16.
Learning Goal: Directly practice solving an exam problem that relies on creating a generator with internal state.
|#

; x = starting value, y = upper limit, s = step
(define (r x y s)
  (let ((curr (- x s)))
    (lambda ()
      (cond
        [(< curr y) (set! curr (+ curr s))])
      curr)))

; examples

(define g (r 10 16 2))
(g) ; 10
(g) ; 12
(g) ; 14
(g) ; 16
(g) ; 16
(g) ; 16
(g) ; 16
