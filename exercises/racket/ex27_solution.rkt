#lang racket

#|
Exercise 27: multi-list->vector (from PPL2021.01.20)

Description: Implement the `multi-list->vector` function. It takes a deep list and converts it into a nested data structure where each level of list is converted into a vector.
E.g.: (multi-list->vector '(1 (2 3) 4)) should return #(1 #(2 3) 4).
Learning Goal: Combine deep recursion with vector operations. This is a direct application from an exam.
|#

; questo codice è scritto da un genio

(define (multi-list->vector item)
  (if (list? item)
      ; --- Recursive Step ---
      ; If the item is a list:
      ; 1. Recursively call this function on each of its elements using `map`.
      ; 2. Convert the resulting list of processed elements into a vector.
      (list->vector (map multi-list->vector item))
      
      ; --- Base Case ---
      ; If the item is an atom (not a list), return it unchanged.
      item))


; --- Example Usage ---

(display "Input: '(1 (2 3) 4)")
(newline)
(display "Output: ")
(displayln (multi-list->vector '(1 (2 3) 4)))
; Expected: #(1 #(2 3) 4)

(newline)

(display "Input: '(a (b (c) d) e)")
(newline)
(display "Output: ")
(displayln (multi-list->vector '(a (b (c) d) e)))
; Expected: #(a #(b #(#(c)) d) e)

(newline)

(display "Input: '(1 () 3)")
(newline)
(display "Output: ")
(displayln (multi-list->vector '(1 () 3)))
; Expected: #(1 #() 3)
