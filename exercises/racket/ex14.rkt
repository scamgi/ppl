#lang racket

#|
Exercise 14: Depth of a List

Description: Write a function depth that computes the maximum nesting level of a list. An atom or empty list has a depth of 0.
E.g.: (depth '(1 (2) ((3)))) should return 3.
Learning Goal: Practice using recursion to calculate a property of the structure itself, not just its elements.
|#

(define (depth a-list)
  (cond
    ; base case
    [(empty? a-list) 1]

    ; case 2: the first element is a number, or in general not a list
    [(not (list? (car a-list))) (max 1 (depth (cdr a-list)))]
    
    ; case 3: the first element is a list
    [else (max (+ 1 (depth (car a-list))) (depth (cdr a-list)))]))

; examples

(depth '(1 (2) ((3)))) ; (depth '(1 (2) ((3)))) should return 3
(depth '(1 (3))) ; (depth '(1 (3))) should return 2
(depth '(1 (((4))))) ; (depth '(1 (((4))))) should return 4
