#lang racket

#|
Exercise 28: create-matrix (from PPL2021.08.31)

Description: Write a procedure that takes a dimension n and a default value, and creates an n-by-n matrix (a vector of vectors) filled with that default value.
E.g.: (create-matrix 2 #f) should return #( #(#f #f) #(#f #f) ).
Learning Goal: Practice nested iteration/recursion for creating 2D structures with vectors.
|#

(define (create-matrix n default-value)
  (let ((v (make-vector n)))
    (for ([i (in-range n)])
      (vector-set! v i (make-vector n))
      (for ([j (in-range n)])
        (vector-set! (vector-ref v i) j default-value)))
    v))

; examples

(define example (create-matrix 4 "c"))

(displayln example)

; SONO GESU CRISTO CAZZO
