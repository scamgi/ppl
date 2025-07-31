#lang racket

(define-syntax-rule (my-delay expression)
  (let ([evaluated? #f]
        [result #f])
    (lambda ()
      (unless evaluated?
        (set! result expression) ; <-- FIX: Removed the outer parentheses
        (set! evaluated? #t))
      result)))

(define (my-force promise)
  (promise))

; --- Example Usage ---
(displayln "Creating a delayed expression...")
(define p
  (my-delay
    (begin
      (displayln "--> Evaluating the expensive expression NOW! <--")
      (* 10 20))))
(displayln "Promise created. Nothing has been evaluated yet.")

(displayln "Forcing the promise for the first time...")
(define val1 (my-force p))
(displayln (string-append "Result 1: " (number->string val1)))

(displayln "\nForcing the promise for the second time...")
(define val2 (my-force p))
(displayln (string-append "Result 2: " (number->string val2)))
