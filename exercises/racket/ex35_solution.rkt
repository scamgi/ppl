#lang racket

(define queue-cc '())

(define (for-each/cc predicate lst body)
  (for-each
   (lambda (element)
     (when (predicate element)
       (call/cc
        (lambda (k)
          (set! queue-cc (append queue-cc (list k))))))
     (body element))
   lst))

(define (use-cc)
  (when (not (null? queue-cc))
    (let ((k (car queue-cc))) ; Get the oldest continuation
      (set! queue-cc (cdr queue-cc)) ; Remove it from the queue
      (k #f)))) ; Invoke the continuation

;; --- Demonstration ---

; We will loop through a list of numbers.
; The predicate `odd?` will be true for 1, 3, and 5.
; The body `displayln` will simply print each number.
(for-each/cc odd? '(1 2 3 4 5) displayln)

; At this point, the queue-cc has three continuations saved in it.
; The first one saved is a bookmark to "the rest of the loop after processing 1".
; The second one is a bookmark to "the rest of the loop after processing 3".
; The third is a bookmark to "the rest of the loop after processing 5".

(printf "--- Now we will use the saved continuations ---\n")

; First call to use-cc:
; It will grab the OLDEST continuation (the one saved when the element was 1).
; It will jump back into the loop right after the number 1 was processed.
(use-cc)

(printf "\n--- Let's use another one ---\n")

; Second call to use-cc:
; It will grab the next oldest continuation (saved when the element was 3).
; It will jump back into the loop right after the number 3 was processed.
(use-cc)

(printf "\n--- And the last one ---\n")

; Third call to use-cc:
; It will jump to the point after 5 was processed.
(use-cc)

(printf "\n--- One more time to be sure ---\n")

; Final call to use-cc:
; The queue is now empty.
(use-cc)
