#lang racket

#|
If the list is empty, it should return 0.
If the list has a length of 1, it should return the only value.
If the list has more than one number, it should return the first
  value with the sum of the other values.
|#

(define (sum-list l)
  [if (= 0 (length l)) 0 ; else if it has a length of 1
    (if (= 1 (length l)) (car l) ; else if it has a length of more than 1
      (+ (car l) (sum-list (cdr l))))])

(sum-list '(1 2 3 4))   ; This should produce 10
(sum-list '(5 10 15))   ; This should produce 30
(sum-list '(1))         ; This should produce 1
(sum-list '())          ; This should produce 0
