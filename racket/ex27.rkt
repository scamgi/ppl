#lang racket

#|
Exercise 27: multi-list->vector (from PPL2021.01.20)

Description: Implement the multi-list->vector function. It takes a deep list and converts it into a nested data structure where each level of list is converted into a vector.
E.g.: (multi-list->vector '(1 (2 3) 4)) should return #(1 #(2 3) 4).
Learning Goal: Combine deep recursion with vector operations. This is a direct application from an exam.
|#

; i need to check if the list is empty

(define (multi-list->vector a-list)
  (let* ((len (length a-list))
         (v (make-vector len)))
    (for ([i (in-range len)])
      (let ((first-element (car a-list)))
        (if (vector? first-element)
          ; if the first element is a vector
          (vector-set! v i ))))))