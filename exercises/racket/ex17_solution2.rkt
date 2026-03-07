#lang racket

(define (add1 x) (+ x 1))
(define (sqr x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (list-to-compose funcs)
  ;; We fold the list of functions from the right using our 'compose' procedure.
  ;; The starting value (the "base case") is the identity function.
  (foldr compose (lambda (x) x) funcs))


; --- Test ---
(define composed-func-fold (list-to-compose (list sqr add1)))
(printf "Fold solution for ((list-to-compose '(sqr add1)) 5) -> ~a\n"
        (composed-func-fold 5)) ; Correctly returns 36

; --- Even more complex test ---
(define (double x) (* x 2))
; This should calculate double(sqr(add1(5))) = double(36) = 72
(define composed-func-3 (list-to-compose (list double sqr add1)))
(printf "Fold solution for ((list-to-compose '(double sqr add1)) 5) -> ~a\n"
        (composed-func-3 5)) ; Correctly returns 72
