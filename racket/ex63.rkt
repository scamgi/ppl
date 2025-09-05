#|
Exercise 63: Group Consecutive Elements

Description: Write a function group-consecutive that takes a list and groups identical consecutive elements into sub-lists.
E.g.: (group-consecutive '(1 1 2 3 3 3 1 1)) should return '((1 1) (2) (3 3 3) (1 1)).
Learning Goal: A more complex recursive pattern that requires "looking ahead" or passing state about the previous element.
|#

#lang racket

(define (group-consecutive lst)
  (define (group-consecutive-helper acc lst-h)
    (cond
      ; base case 1
      [(empty? lst-h) (reverse acc)]

      ; base case 2
      [(empty? (car acc)) '((car lst-h))]
      
      ; the first element is different from the first element of the list
      [(not (eq? (car (car acc)) (car lst-h))) (group-consecutive-helper (append (list (car lst-h) acc) (cdr lst-h)) (cdr lst-h))]
      
      ; the first element is equal to the first element of the list
      [else (group-consecutive-helper (append (list (cons (car lst-h) (car acc))) (cdr acc)) (cdr lst-h))]))
  (group-consecutive-helper '('()) lst))

; examples
(group-consecutive '(1 1 2 3 3 3 1 1)) ; '((1 1) (2) (3 3 3) (1 1))
