#lang racket

(define (add1 x) (+ x 1))
(define (sqr x) (* x x))

(define (list-to-compose-recursive funcs)
  ;; Base Case: If there are no functions, the composition is the
  ;; identity function--a function that returns its input unchanged.
  (if (empty? funcs)
      (lambda (x) x)
      
      ;; Recursive Step:
      ;; 1. Get the first function 'f'.
      ;; 2. Recursively get the composed function for the rest of the list, 'g'.
      ;; 3. Return a new function that applies f to the result of applying g to x.
      (let ([f (car funcs)]
            [g (list-to-compose-recursive (cdr funcs))])
        (lambda (x)
          (f (g x))))))


; --- Test ---
(define composed-func (list-to-compose-recursive (list sqr add1)))
(printf "Recursive solution for ((list-to-compose '(sqr add1)) 5) -> ~a\n"
        (composed-func 5)) ; Correctly returns 36
