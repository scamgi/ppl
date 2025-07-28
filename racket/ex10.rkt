#lang racket

#|
Exercise 10: Implement my-foldr (Fold Right)

Description: Implement the foldr (or fold-right) function. It takes a procedure, a base value, and a list. It combines the elements of the list from right to left.
E.g.: (my-foldr cons '() '(1 2 3)) should be equivalent to (cons 1 (cons 2 (cons 3 '()))), returning (1 2 3).
Learning Goal: Understand the fundamental "catamorphism" for lists, the most powerful list processing tool. Many other functions can be defined using foldr.
|#

(define (my-foldr func base-value a-list)
  (if (empty? a-list)
    base-value          ; #t case
    (func (car a-list) (my-foldr func base-value (cdr a-list)))))

; examples

(my-foldr cons '() '(1 2 3)) ; should return '(1 2 3)
(my-foldr + 0 '(1 2 3)) ; should return 6
