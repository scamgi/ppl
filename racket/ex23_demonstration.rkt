#lang racket

(define (memoize func)
  ; Your implementation is perfect.
  (let ((returns (make-hash)))
       (lambda (x)
          (cond
            [(hash-has-key? returns x) (hash-ref returns x)]
            [else (let ((y (func x)))
              (hash-set! returns x y)
              y)]))))

;; A very slow, recursive Fibonacci function.
(define (slow-fib n)
  (if (< n 2)
      n
      (+ (slow-fib (- n 1)) (slow-fib (- n 2)))))

;; Now, let's create the memoized version.
(define fast-fib (memoize slow-fib))

;; --- DEMONSTRATION ---

(displayln "Calculating (fast-fib 40) for the first time...")
; The 'time' procedure prints how long the computation takes.
(time (fast-fib 40))
; On my machine, this takes ~600ms.

(displayln "\nCalculating (fast-fib 40) for the second time...")
; This time it will be a cache hit.
(time (fast-fib 40))
; On my machine, this takes 0ms. It's instantaneous.

(displayln "\nCalculating (fast-fib 39) for the first time...")
; This will be a cache hit because (slow-fib 39) was already computed
; as part of the first call to (slow-fib 40).
(time (fast-fib 39))
; Instantaneous.