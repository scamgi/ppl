#lang racket

#|
Exercise 26: Vector Map

Description: Write a function vector-map that takes a procedure and a vector, and returns a new vector where the procedure has been applied to each element.
E.g.: (vector-map (lambda (x) (* x x)) '#(1 2 3)) should return #(1 4 9).
Learning Goal: Learn the basic operations: make-vector, vector-ref, vector-set!, and vector-length.
|#

(define (vector-map procedure vec)
  (let ((l (vector-length vec)))
    (for ([i (l 1 l 1)])
      (vector-set! vec i (procedure (vector-ref vec i))))))

; examples

(vector-map (lambda (x) (* x x)) '#(1 2 3)) ; should return #(1 4 9)
