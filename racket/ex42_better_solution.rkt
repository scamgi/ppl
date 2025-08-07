#lang racket

(define (my-foldl proc initial-val lst)
  ;; The base case: if the list is empty, the work is done.
  ;; Return the accumulated value.
  (if (empty? lst)
      initial-val
      ;; Recursive step:
      ;; 1. Apply the procedure to the current accumulator (initial-val)
      ;;    and the first element of the list.
      ;; 2. This result becomes the NEW initial-val for the next call.
      ;; 3. Make the recursive call on the rest of the list.
      (my-foldl proc (proc initial-val (car lst)) (cdr lst))))
