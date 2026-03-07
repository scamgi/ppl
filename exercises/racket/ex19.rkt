#lang racket

#|
Exercise 19: mix (from PPL2021.06.22)

Description: Define the function mix which takes a function as its first argument, followed by a variable number of other arguments.
E.g.: (mix (lambda (x) (* x x)) 1 2 3) should return (1 (2 (3 (1 4 9) 3) 2) 1).
Learning Goal: Combine variadic functions, higher-order functions, and complex list-building recursion to solve a challenging exam problem.
|#


; first I compute the cental list, so I use map func items to create it
; then I need to get the last value and do (cons 3 '(res 3))
; then I do (cons 2 '(res 2))
; etc
;
; to take the last element and then remove it each time, I can reverse the list

; but I should procede in the opposite way. I first create the structure:
; (1 (2 (3 (...) 3) 2) 1)
; and then I compute the central part

(define (mix func . items)
  ; this is the actual function
  (define (helper remaining)
    (if (empty? remaining)
      ; I build the central part
      (map func items)
        
      ; otherwise I need to create (1 '(...) 1) etc
      (list (car remaining) (helper (cdr remaining)) (car remaining))))
  
  ; this is where it starts
  (if (empty? items)
    ; I return nothing
    '()
    
    ; else I return the execution of the function
    (helper items)))

; examples

(displayln (mix (lambda (x) (* x x)) 1 2 3))
; (1 (2 (3 (1 4 9) 3) 2) 1)
