#lang racket

#|

Exercise 4: Appending Lists

Description: Without using append, write a recursive function my-append that takes two lists and returns a new list containing all elements of the first followed by all elements of the second.
E.g.: (my-append '(1 2) '(3 4)) should return (1 2 3 4).
Learning Goal: Understand how to reconstruct a list during the recursive process using cons.

|#

(define (my-append l1 l2)
  (if
    (empty? l1)   ; condition
    
    l2            ; then-expression

    (cons (car l1) (my-append (cdr l1) l2))))

;; --- Test Cases ---

;; 1. Standard Case: Two non-empty lists of numbers
(display "Test 1: Standard case -> ")
(my-append '(1 2 3) '(4 5 6))
; Expected: '(1 2 3 4 5 6)


;; 2. Edge Case: First list is empty
(display "Test 2: First list empty -> ")
(my-append '() '(a b c))
; Expected: '(a b c)


;; 3. Edge Case: Second list is empty
(display "Test 3: Second list empty -> ")
(my-append '(10 20 30) '())
; Expected: '(10 20 30)


;; 4. Edge Case: Both lists are empty
(display "Test 4: Both lists empty -> ")
(my-append '() '())
; Expected: '()


;; 5. Single-element lists
(display "Test 5: Single-element lists -> ")
(my-append '(1) '(2))
; Expected: '(1 2)


;; 6. Lists with mixed data types
(display "Test 6: Mixed data types -> ")
(my-append '(1 "hello" #t) '(symbol 4.5))
; Expected: '(1 "hello" #t symbol 4.5)


;; 7. One list is much longer than the other
(display "Test 7: Unbalanced lists -> ")
(my-append '(a) '(b c d e f g))
; Expected: '(a b c d e f g)
