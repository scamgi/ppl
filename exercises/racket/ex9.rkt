#lang racket

#|
Exercise 9: Implement my-filter

Description: Implement your own version of filter. It should take a predicate (a function that returns #t or #f) and a list, and return a new list containing only the elements for which the predicate returns #t.
E.g.: (my-filter odd? '(1 2 3 4 5)) should return (1 3 5).
Learning Goal: Abstract the selection pattern into a higher-order function.
|#

(define (my-filter pred a-list)
  (cond
    [(empty? a-list) '()]
    [(pred (car a-list)) (cons (car a-list)
                               (my-filter pred (cdr a-list)))]
    [else (my-filter pred (cdr a-list))]))

; examples
(my-filter odd? '(1 2 3 4 5)) ; should return '(1 3 5)
(my-filter even? '(1 2 3 4 5)) ; should return '(2 4)
(my-filter positive? '(1 2 3 4 5)) ; should return '(1 2 3 4 5)
(my-filter positive? '()) ; should return '()
