#|
Exercise 61: Interleave Two Lists

Description: Write a function interleave that takes two lists and returns a new list containing elements from each, alternating. If one list is longer, its remaining elements should be appended at the end.
E.g.: (interleave '(a b c) '(1 2 3 4 5)) should return '(a 1 b 2 c 3 4 5).
Learning Goal: Practice recursion over multiple lists at once.
|#

#lang racket

(define (interleave lst1 lst2)
  (define (interleave-helper acc lst1-helper lst2-helper)
    (cond
      ; base case 1
      [(empty? lst1-helper) (append acc lst2-helper)]

      ; base case 2
      [(empty? lst2-helper) (append acc lst1-helper)]

      ; normal case
      [else (interleave-helper (cons (car lst1-helper) (cons (car lst2-helper) acc)) (cdr lst1-helper) (cdr lst2-helper))]))
    
  (interleave-helper '() lst1 lst2))

; examples

(interleave '(a b c) '(1 2 3 4 5)) ; '(a 1 b 2 c 3 4 5)


(define (interleave-final lst1 lst2)
  (define (interleave-helper acc lst1-h lst2-h)
    (cond
      [(empty? lst1-h) (append (reverse acc) lst2-h)]
      [(empty? lst2-h) (append (reverse acc) lst1-h)]
      [else
       (interleave-helper (cons (car lst2-h) (cons (car lst1-h) acc))
                          (cdr lst1-h)
                          (cdr lst2-h))]))
  (interleave-helper '() lst1 lst2))


(interleave-final '(a b c) '(1 2 3 4 5))
