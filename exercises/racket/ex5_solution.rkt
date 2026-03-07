#lang racket

;; -----------------------------------------------------------------------------
;; Function Definition
;; -----------------------------------------------------------------------------

(define (my-reverse lst)
  ;; Helper function using an accumulator
  (define (reverse-helper current-list acc)
    (if (empty? current-list)
        acc
        (reverse-helper (rest current-list) (cons (first current-list) acc))))
  
  ;; Initial call to the helper
  (reverse-helper lst '()))

;; -----------------------------------------------------------------------------
;; Test Calls
;;
;; Call the function with different inputs and print the results.
;; -----------------------------------------------------------------------------

(displayln "--- Testing my-reverse ---")

;; Test 1: An empty list
(displayln "Input: '()")
(display "Output: ")
(displayln (my-reverse '())) ; Expected output: '()

;; Test 2: A list with a single element
(displayln "\nInput: '(42)")
(display "Output: ")
(displayln (my-reverse '(42))) ; Expected output: '(42)

;; Test 3: A standard list of numbers
(displayln "\nInput: '(1 2 3 4 5)")
(display "Output: ")
(displayln (my-reverse '(1 2 3 4 5))) ; Expected output: '(5 4 3 2 1)

;; Test 4: A list with mixed data types
(displayln "\nInput: '(\"hello\" #t 100)")
(display "Output: ")
(displayln (my-reverse '("hello" #t 100))) ; Expected output: '(100 #t "hello")

;; Test 5: A list containing other lists (the inner lists are not reversed)
(displayln "\nInput: '((1 2) (3 4) 5)")
(display "Output: ")
(displayln (my-reverse '((1 2) (3 4) 5))) ; Expected output: '(5 (3 4) (1 2))

(displayln "\n--- Tests Complete ---")
