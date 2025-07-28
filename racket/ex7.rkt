#lang racket

#|
Exercise 7: Implement my-map

Description: Implement your own version of map. It should take a procedure and a list, and apply the procedure to every element of the list, returning a new list of the results.
E.g.: (my-map (lambda (x) (* x 2)) '(10 20 30)) should return (20 40 60).
Learning Goal: Abstract the transformation pattern into a higher-order function. This is a critical skill seen in many exam questions.
|#

(define (my-map func a-list)
  (if (empty? a-list) ; condition
    '()               ; I return '()
    (let
      ((x (car a-list)))
      (cons (func x) (my-map func (cdr a-list))))
  ))

; examples
(my-map (lambda (x) (* x 2)) '(10 20 30)) ; should return '(20 40 60)
(my-map (lambda (x) (+ x 2)) '(10 20 30)) ; should return '(12 22 32)
