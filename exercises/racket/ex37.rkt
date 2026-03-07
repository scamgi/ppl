#lang racket

#|
Exercise 37: A swap! Macro

Description: Write a macro swap! that takes two variable names and swaps their values.
E.g.: (define a 5) (define b 10) (swap! a b) should result in a being 10 and b being 5.
Learning Goal: Illustrate how macros can achieve effects that functions cannot (like re-assigning free variables).
|#

(define-syntax swap!
  (syntax-rules ()
    [(_ a b)
      (let ([temp a]) ; Create a temporary variable 'temp' holding the value of 'a'.
        (set! a b)      ; Assign the value of 'b' to 'a'.
        (set! b temp))])) ; Assign the stored value from 'temp' to 'b'.

;; --- Demonstration ---

(define first-val 100)
(define second-val 200)

(printf "Before swap:\n")
(printf "  first-val: ~v\n" first-val)
(printf "  second-val: ~v\n\n" second-val)

; Call the macro to swap the values of the two variables.
(swap! first-val second-val)

(printf "After swap:\n")
(printf "  first-val: ~v\n" first-val)
(printf "  second-val: ~v\n" second-val)
