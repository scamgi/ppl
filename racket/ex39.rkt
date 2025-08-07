#lang racket

#|
Exercise 39: Implement let-cond (from PPL2024.06.06)

Description: Implement the let-cond macro. It should test conditions in order. For the first one that is true, it should create the associated bindings and execute the corresponding "then-part". If all are false, it executes an else-part.
Learning Goal: Write a more complex macro that transforms a custom structure into a standard cond expression.
|#

(define-syntax let-cond
  (syntax-rules (else)
    ;; Rule 1: Handles the case WITH an 'else' clause
    [(_ [condition ((var val) ...) body ...] ... [else ((else-var else-val) ...) else-body ...])
      (cond
        [condition (let ((var val) ...) body ...)] ...
        [else (let ((else-var else-val) ...) else-body ...)])]
    ;; Rule 2: Handles the case WITHOUT an 'else' clause
    [(_ [condition ((var val) ...) body ...] ...)
      (cond
        [condition (let ((var val) ...) body ...)] ...)]))

(let-cond
  [(= 1 2) 
   ((msg "This won't print"))
   (displayln msg)]
   
  [(string? 10)
   ((msg "This won't print either"))
   (displayln msg)])

(displayln "The let-cond above did nothing.")
