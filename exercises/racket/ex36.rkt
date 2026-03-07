#lang racket

#|
Exercise 36: A Simple when-not Macro

Description: Write a macro when-not that is the opposite of when. (when-not <condition> <body> ...) should execute the body only if the condition is false.
E.g.: (when-not (= 2 2) (displayln "hello")) should do nothing.
Learning Goal: Understand the basic structure of define-syntax and syntax-rules.
|#

(define-syntax when-not
  (syntax-rules ()
    [(_ condition body ...)
      (when (not condition)
        body ...)]))

;; --- Demonstration ---

(printf "--- Test 1: Condition is true, so body should NOT execute. ---\n")
(when-not (= 5 5)
  (displayln "This should never be printed.")
  (displayln "The macro is working correctly for a true condition."))
(printf "--- Test 1 finished. ---\n\n")


(printf "--- Test 2: Condition is false, so body SHOULD execute. ---\n")
(define x 10)
(when-not (> x 20)
  (displayln "The condition (> x 20) is false.")
  (displayln "Therefore, this line is printed.")
  (displayln "The macro is working correctly!"))
(printf "--- Test 2 finished. ---\n")
