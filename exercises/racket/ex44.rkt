#lang racket

#|
Exercise 44: Range Generator

Description: Write a tail-recursive function range that takes a start and end integer and returns a list of numbers from start up to (but not including) end.
E.g.: (range 3 7) should return (3 4 5 6).
Learning Goal: Practice building a list in reverse using an accumulator and then reversing it once at the end for the correct order, a common tail-recursive list-building pattern.
|#

(define (range start end)
  (define (range-helper acc minimum maximum)
    (cond
      [(>= minimum maximum) (reverse acc)]
      [else (range-helper (cons minimum acc) (+ minimum 1) maximum)]))
  (range-helper '() start end))

(range 1 4) ; '(1 2 3)
(range 4 8) ; '(4 5 6 7)
(range 4 4) ; '()
