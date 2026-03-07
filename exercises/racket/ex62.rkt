#|
Exercise 62: zip

Description: Implement the zip function. It takes two lists and returns a list of pairs, where the i-th pair contains the i-th element from each list. The output list's length is determined by the shorter of the two input lists.
E.g.: (zip '(a b c) '(1 2)) should return '((a 1) (b 2)).
Learning Goal: A classic multi-list recursion that is fundamental for many other operations.
|#

#lang racket

(define (zip lst1 lst2)
  (define (zip-helper acc lst1-h lst2-h)
    (cond
      [(or (empty? lst1-h) (empty? lst2-h)) (reverse acc)]
      [else (zip-helper (cons (list (car lst1-h) (car lst2-h)) acc) (cdr lst1-h) (cdr lst2-h))]))
  (zip-helper '() lst1 lst2))

; example

(zip '(a b c) '(1 2)) ; '((a 1) (b 2))
