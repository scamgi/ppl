#lang racket

#|
Exercise 8: Simple Filter

Description: Write a function filter-even that takes a list of numbers and returns a new list containing only the even numbers.
E.g.: (filter-even '(1 2 3 4 5 6)) should return (2 4 6).
Learning Goal: See the pattern of selecting elements based on a predicate, motivating the need for filter.
|#

(define (filter-even a-list)
  (filter even? a-list))

; examples
(filter-even '(1 2 3 4 5 6)) ; should return '(2 4 6)
(filter-even '()) ; should return '()
(filter-even '(2 3 6)) ; should return '(2 6)
