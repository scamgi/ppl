#lang racket

#|
Exercise 12: Flatten a List

Description: Write a function flatten that takes a deep list and returns a single, "flat" list containing all the atoms in order.
E.g.: (flatten '(1 (2 (3)) 4 (5 6))) should return (1 2 3 4 5 6).
Learning Goal: Practice combining results from nested recursive calls using append. This is a very common pattern.
|#

#|
(define (flatten deep-list)
  (cond
    ; Base case: empty list
    [(empty? deep-list) '()]

    ; Case 2: first element of the list is a list
    [(list? (car deep-list)) (cons (flatten (car deep-list)) (flatten (cdr deep-list)))]
    
    ; Case 3: first element is an element and not a list
    [else (cons (car deep-list) (flatten (cdr deep-list)))]))
|#

; FIX

(define (flatten deep-list)
  (cond
    ; Base case: empty list
    [(empty? deep-list) '()]

    ; Case 2: first element of the list is a list
    [(list? (car deep-list)) (append (flatten (car deep-list)) (flatten (cdr deep-list)))]
    
    ; Case 3: first element is an element and not a list
    [else (cons (car deep-list) (flatten (cdr deep-list)))]))

; examples
(flatten '()) ; returns '()
(flatten '(1 2 3)) ; returns '(1 2 3)
(flatten '(1 (2) 3)) ; returns '(1 2 3)
(flatten '(1 ((2) 3) 4)) ; returns '(1 2 3 4)
(flatten '(1 (2 (3)) 4 (5 6))) ; returns '(1 2 3 4 5 6)
