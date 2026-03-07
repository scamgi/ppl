#lang racket

#|

Exercise 5: Reversing a List

Description: Write a function my-reverse that reverses a list. You may want to use a helper function with an accumulator.
E.g.: (my-reverse '(1 2 3)) should return (3 2 1).
Learning Goal: Introduce the powerful concept of an accumulator to build a result during recursion, which is essential for tail-recursive solutions.

|#

(define (my-reverse l)
  (if (empty? l)
    l
    (cons (last l) (my-reverse (take l (- (length l) 1))))))

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
