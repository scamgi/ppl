#lang racket

(define (depth-alternative L)
  (if (not (list? L))
      0 ; An atom has depth 0, as per the (corrected) definition.
      (if (empty? L)
          1 ; A non-empty flat list will have depth 1. This is our base.
          (+ 1 (apply max (map depth-alternative L))))))

; this is insane btw. 
; this is a very complex way to use apply.
