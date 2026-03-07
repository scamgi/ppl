#lang racket

(define (my-member? item l)
  (cond
    ;; Case 1: The list is empty, so the item cannot be found.
    [(empty? l) #f]

    ;; Case 2: The first element of the list is a match.
    [(equal? item (car l)) #t]

    ;; Otherwise, the item isn't at the front, so check the rest of the list.
    [else (my-member? item (cdr l))]))

;; --- Examples ---
(my-member? 'b '(a b c))      ; -> #t
(my-member? 'd '(a b c))      ; -> #f
(my-member? "cat" '("dog" "cat" "bird")) ; -> #t (works thanks to equal?)
(my-member? 5 '())           ; -> #f
