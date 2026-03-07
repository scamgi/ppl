#lang racket

#|
Exercise 25: delay and force (Call-by-Need)

Description: Implement the delay and force constructs. (delay <expr>) should return a "promise" without evaluating <expr>. (force <promise>) should evaluate the expression the first time it's called and cache the result for subsequent calls.
Learning Goal: Understand and implement lazy evaluation, a key computer science concept that uses closures and state. This prepares you for the delay-master problem in PPL2024.09.03.
|#

(define (delay expr)
  (let ((cache null))
    (lambda ()
      (if (not (null? cache))
        cache
        (begin
          (set! cache (expr))
          cache)))))

(define (force expr)
  (expr))

