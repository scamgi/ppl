#lang racket

#|
Exercise 13: Deep Map

Description: Write a function deep-map that takes a procedure and a deep list. It should return a new deep list with the same structure, but with the procedure applied to every atom.
E.g.: (deep-map (lambda (x) (* x x)) '(1 (2 3))) should return (1 (4 9)).
Learning Goal: Combine the logic of map with deep recursion. This directly relates to the multi-list->vector problem (PPL20210120).
|#

(define (deep-map func a-list)
  (cond
    ; base case
    [(empty? a-list) '()]
    ; case 2: the first element is a list
    [(list? (car a-list)) (cons (deep-map func (car a-list)) (deep-map func (cdr a-list)))]
    ; case 3; the first element is a number
    [else (cons (func (car a-list)) (deep-map func (cdr a-list)))]))

; examples

(deep-map (lambda (x) (* x x)) '(1 (2 3))) ; should return '(1 (4 9))
(deep-map (lambda (x) (+ x 2)) '(1 (2) 3 ((4) 5))) ; should return '(3 (4) 5 ((6) 7))
