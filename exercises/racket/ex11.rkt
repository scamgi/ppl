#lang racket

#|
Exercise 11: Count All Atoms

Description: Write a function deep-count that takes a list which may contain other lists (a "deep list") and counts the total number of non-list atoms.
E.g.: (deep-count '(1 (2 3) 4 ((5)))) should return 5.
Learning Goal: Adapt the basic recursion pattern to handle nested structures by checking (list? ...) and making two recursive calls when a sub-list is found.
|#

(define (deep-count a-list)
  (cond
    [(empty? a-list) 0]
    [(list? (car a-list)) (+ (deep-count (car a-list)) (deep-count (cdr a-list)))]
    [else (+ 1 (deep-count (cdr a-list)))]))

; examples
(deep-count '(1 (2 3) 4 ((5)))) ; should return 5
(deep-count '(1 (2))) ; should return 2
(deep-count '(1 (2 3) 4 (((5 6))))) ; should return 6
