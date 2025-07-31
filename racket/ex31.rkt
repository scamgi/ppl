#lang racket

#|
Exercise 31: Find First Negative

Description: Write a function find-first-negative that searches a list of numbers. It should return the first negative number it finds immediately, without processing the rest of the list. If no negative numbers are found, it should return #f.
Learning Goal: Understand the fundamental use of call/cc to create an "escape hatch" from a computation.
|#

; directly from Gemini

(define (find-first-negative lst)
  (displayln "Starting the search...")
  
  ; call/cc captures the current continuation.
  ; We'll name our continuation 'exit', because it's our escape hatch.
  (call/cc
    (lambda (exit)
      ; The rest of the code runs inside this lambda.
      ; If 'exit' is ever called, the entire call/cc expression
      ; will immediately stop and return the value passed to 'exit'.

      (for-each
       (lambda (x)
         (display "Checking number: ")
         (displayln x)
         
         (when (negative? x)
           ; We found it! Use the escape hatch to exit immediately.
           ; The whole search will stop and return 'x'.
           (exit x)))
       lst)
      
      ; This line is only reached if the loop finishes
      ; without finding any negative numbers. This becomes the
      ; final return value of the call/cc expression.
      #f)))

; --- Let's test it ---

(displayln "--- Test Case 1: Negative number is in the middle ---")
(define result1 (find-first-negative '(5 8 -3 10 12)))
(display "Result 1: ")
(displayln result1)
; Notice how "10" and "12" are never checked.

(newline)

(displayln "--- Test Case 2: No negative numbers ---")
(define result2 (find-first-negative '(1 2 3 4)))
(display "Result 2: ")
(displayln result2)
