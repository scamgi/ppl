#lang racket

#|
Exercise 35: for-each/cc (from PPL2023.01.25)

Description: Implement the for-each/cc procedure. It takes a predicate, a list, and a body. When the predicate is true for an element, the continuation of the body is stored in a global queue. A separate use-cc procedure should invoke the oldest continuation from the queue.
Learning Goal: Work with a queue of continuations instead of a stack, and understand how continuations capture the rest of the computation.
|#

(define queue-cc '())

(define (for-each/cc predicate list body)
  ; verifies list is not empty
  (when (not (empty? list))
    ; if the predicate is true, it creates a new continuation
    (when (predicate list)
      (set! queue-cc (cons (call/cc body) queue-cc)))
    ; then it calls itself with the rest of the list
    (for-each/cc predicate (cdr list) body)))

(define (use-cc)
  (when (not (empty? queue-cc))
    ; calls the continuation
    ((last queue-cc))
    
    ; removes the last item
    (set! queue-cc (take queue-cc (- (length queue-cc) 1)))))

