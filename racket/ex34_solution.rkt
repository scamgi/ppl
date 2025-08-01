#lang racket

;; Our correct and final implementations
(define cc-stack '())

(define (store-cc)
  (call/cc
   (lambda (k)
     (set! cc-stack (cons k cc-stack)))))

(define (run-cc)
  (when (not (empty? cc-stack))
    (let ((k (car cc-stack)))
      (set! cc-stack (cdr cc-stack))
      ;; Invoke the continuation. The value it returns is irrelevant
      ;; in this example, so we use (void).
      (k (void)))))


; --- A SIMPLER, CLEARER EXAMPLE ---

(define (test-procedure)
  (printf " -> test-procedure started.\n")
  (printf " -> Storing continuation now...\n")
  (store-cc)
  (printf " -> The program continues after store-cc.\n")
  (printf " -> test-procedure finished.\n"))


(printf "1. Program starting.\n")
(printf "   The stack is: ~a\n" cc-stack)
(printf "\n")

(printf "2. Calling test-procedure for the first time.\n")
(test-procedure)
(printf "\n")

(printf "3. The program is now after test-procedure.\n")
(printf "   The stack is: ~a\n" cc-stack)
(printf "\n")

(printf "4. Now calling run-cc...\n")
(run-cc)
(printf "\n")

(printf "5. The program has finally finished for real.\n")
