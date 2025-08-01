#lang racket

#|
Exercise 33: A Loop with break

Description: Write a loop-with-break function that takes a list and a procedure body. It should iterate through the list, calling body on each element. Inside body, a globally available function break should be able to be called to immediately exit the loop and return a value.
Learning Goal: Practice setting up a continuation that can be used by a separate, nested procedure. This is the core of the For loop problems.
|#


; my code which is not completely correct
#|
(define (break)
  (exit))

(define (loop-with-break lst body)
  (call/cc
    (lambda (exit)
      (define (loop rest)
        (cond
          [(not (empty? rest)) (begin
            (body (car rest))
            (loop (cdr rest)))])))))
|#

(define (loop-with-break lst body)
  ;; Get the exit continuation.
  (call/cc
   (lambda (exit)
     ;; Define a recursive helper.
     (define (loop rest)
       (when (not (empty? rest))
         ;; The key change is here: we pass `exit` to the body.
         (body (car rest) exit)
         (loop (cdr rest))))

     ;; Start the loop.
     (loop lst)

     ;; If the loop finishes without `break` being called, return a default value.
     'complete)))


; --- Examples ---

(displayln "--- Example 1: Loop completes normally ---")
(define result1
  (loop-with-break
   '(1 2 3 4)
   ;; The user's lambda now accepts `item` and `break`.
   (lambda (item break)
     (printf "Processing item: ~a\n" item)
     (when (= item 100)
       (break 'found-a-hundred))))) ; `break` is now a local variable.
(printf "Final result: ~a\n\n" result1) ; Should be 'complete


(displayln "--- Example 2: Loop is broken early ---")
(define result2
  (loop-with-break
   '(1 2 3 4 5 6 7)
   ;; Same pattern here.
   (lambda (item break)
     (printf "Processing item: ~a\n" item)
     (when (= item 5)
       (break 'i-am-done))))) ; Call the provided `break` function.
(printf "Final result: ~a\n" result2) ; Should be 'i-am-done
