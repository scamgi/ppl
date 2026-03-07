#lang racket

#|

Exercise 3: Element Membership

Description: Write a function my-member? that takes an element and a list and returns #t if the element is in the list, and #f otherwise.
E.g.: (my-member? 'b '(a b c)) should return #t.
Learning Goal: Introduce conditional logic (cond or if) within the recursive structure.

|#

; I will use eq? to make sure the object is the same in the memory.
; base case: if the list is empty, then it should return false
; otherwise, if the first element is the same, I return true, otherwise I return the call
; to the function with the rest of the list

(define (my-member? item l)
  (if (empty? l)                 ; cond
    #f                          ; true case
    (if (eq? item (car l))      ; cond
      #t                        ; true case
      (my-member? item (cdr l)))))

;; --- Examples ---
(my-member? 'b '(a b c))      ; -> #t
(my-member? 'd '(a b c))      ; -> #f
(my-member? "cat" '("dog" "cat" "bird")) ; -> #t (works thanks to equal?)
(my-member? 5 '())           ; -> #f
