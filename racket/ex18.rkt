#lang racket

#|
Exercise 18: Variadic Functions

Description: Write a procedure product that takes a variable number of numeric arguments and returns their product.
E.g.: (product 2 3 4) should return 24.
Learning Goal: Learn the "dot" notation in lambda or define to create variadic functions.
|#

;(define (product . items)
;  (* items))

(define (product . items)
  ;; 'apply' takes a procedure (*) and a list of arguments (items)
  ;; and calls the procedure with those arguments.
  (apply * items))

; --- Let's test it ---

(display "Calling (product 2 3 4): ")
(displayln (product 2 3 4))  ; This now works correctly and prints 24

(display "Calling (product 10 5): ")
(displayln (product 10 5))   ; Prints 50

(display "Calling (product): ")
(displayln (product))      ; Prints 1 (the identity for multiplication)
