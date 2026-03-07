#lang racket

#|
Exercise 6: Simple Map

Description: Write a function square-all that takes a list of numbers and returns a new list with each number squared.
E.g.: (square-all '(1 2 3 4)) should return (1 4 9 16).
Learning Goal: See the pattern of applying a transformation to every element, motivating the need for a generic map.
|#

(define (square-all a-list)
  (map (lambda (n) (* n n)) a-list))

(square-all '(1 2 3 4)) ; should return '(1 4 9 16)
(square-all '(1 5 7 9)) ; should return '(1 25 49 81)
