#lang racket

#|
Exercise 26: Vector Map

Description: Write a function vector-map that takes a procedure and a vector, and returns a new vector where the procedure has been applied to each element.
E.g.: (vector-map (lambda (x) (* x x)) '#(1 2 3)) should return #(1 4 9).
Learning Goal: Learn the basic operations: make-vector, vector-ref, vector-set!, and vector-length.
|#

(define (vector-map procedure vec)
  (let ((l (vector-length vec)))
    ; 2. Create a NEW vector of the same length
    (let ((new-vec (make-vector l)))
      ; 3. Loop through the indices of the vector
      (for ([i (in-range l)])
        (vector-set! new-vec i (procedure (vector-ref vec i))))
      new-vec)))

; --- Examples ---

(define original-vector '#(1 2 3))
(define squared-vector (vector-map (lambda (x) (* x x)) original-vector))

(displayln "Original Vector:")
(displayln original-vector) ; Output: #(1 2 3)

(displayln "New Mapped Vector:")
(displayln squared-vector) ; Correct Output: #(1 4 9)