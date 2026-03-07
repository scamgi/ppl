#|
Exercise 56: For Loop with continue (from PPL2024.01.11)

Description: Extend the For loop macro from Exercise 40 to support both break and continue.
Learning Goal: This is the ultimate continuation challenge. It requires using two nested call/cc calls: an outer one for break (exiting the whole loop) and an inner one for continue (skipping to the next iteration).
|#

#lang racket

(define *exit-store* '())
(define *cont-store* '())
(define (continue)
((car *cont-store*)))
(define (break v)
(set! *cont-store* (cdr *cont-store*))
((car *exit-store*) v))
(define-syntax For
(syntax-rules (from to do)
((_ var from min to max
do body ...)
(let* ((min1 min)
(max1 max)
(inc (if (< min1 max1) + -)))
(let ((v (call/cc
(lambda (k)
(set! *exit-store*
(cons k *exit-store*))
(let loop ((var min1))
(call/cc
(lambda (cont)
(set! *cont-store*
(cons cont *cont-store*))
body ...))
(set! *cont-store* (cdr *cont-store*))
(unless (= var max1)
(loop (inc var 1))))))))
(set! *exit-store* (cdr *exit-store*))
v)))))
