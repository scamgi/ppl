#|
Exercise 34: store-cc and run-cc (from PPL2022.09.01)

Description: Implement the store-cc and run-cc constructs from the exam. store-cc should capture its continuation and push it onto a global stack. run-cc should pop the most recent continuation and invoke it.
Learning Goal: Manage a collection of continuations, a more advanced application of call/cc.
|#

(define global-cc '())

(define (store-cc continuation)
  (set! global-cc (cons continuation global-cc)))

(define (run-cc param)
  (when (not (empty? global-cc))
    (let ((f (car global-cc)))
      (f param))
    (set! global-cc (cdr global-cc))))

