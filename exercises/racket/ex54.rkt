#lang racket

#|
Exercise 54: A while Loop Macro

Description: Implement a traditional while loop as a macro. (while <condition> <body> ...) should execute the body as long as the condition remains true.
Learning Goal: Practice creating a common imperative construct by expanding it into a recursive function (using a named let).
|#

(define-syntax while
    (syntax-rules ()
        [(_ condition body ...)
            (begin
                (define (while-helper)
                    body ...
                    (when condition
                        (while-helper)))
                (when condition
                    (while-helper)))]))

; better solution

(define-syntax while
  (syntax-rules ()
    [(_ condition body ...)
     (let loop () ; Define a local loop function named 'loop'
       (when condition
         body ...
         (loop)))])) ; Recursive call

