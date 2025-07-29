#lang racket

(define (mix g . L)
  ; I create center
  (define center-list (map g L))
  
  ; I use foldr for the rest
  (foldr (lambda (ci ar) (list ci ar ci))
         center-list
         L))

; examples

(displayln (mix (lambda (x) (* x x)) 1 2 3))
; (1 (2 (3 (1 4 9) 3) 2) 1)
