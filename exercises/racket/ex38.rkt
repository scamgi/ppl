#lang racket

#|
Description: Implement the "named let" construct as a macro nlet. (nlet name ((var val) ...) body ...) should be transformed into (let name ((var val) ...) body ...) which in turn expands to a local recursive function.
Learning Goal: Practice a direct, common macro transformation pattern found in an exam.
|#

(define-syntax nlet
  (syntax-rules ()
    [(_ name ((var val) ...) body ...)
      (let name ((var val) ...) body ...)]))

;;; Using nlet for a countdown loop

(define (start-countdown)
  (nlet countdown ([i 5])       ; Use nlet instead of let
    (when (> i 0)
      (displayln i)
      (countdown (- i 1)))))    ; Recurse by calling the loop's name

;; Run the countdown
(start-countdown)
