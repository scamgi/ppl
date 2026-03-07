#lang racket

#|
Exercise 22: Bank Account Object

Description: Write a function make-account that takes an initial balance. It should return a "dispatcher" procedure that accepts messages like 'balance, 'withdraw, and 'deposit.
E.g.: (define acc (make-account 100)) (acc 'deposit 50) (acc 'withdraw 30) (acc 'balance) → 120.
Learning Goal: Implement the object-oriented dispatcher pattern. This is a crucial building block for the define-dispatcher macro seen in PPL2022.07.06.
|#

(define (make-account money)
  (let ((bal money))
    (lambda (action . args)
      ; first, checks the type of action
      (cond
        ; if the action is balance, I return the balance
        [(equal? action 'balance) bal]

        ; if the action is withdraw, I remove the amount from the balance
        [(equal? action 'withdraw) (set! bal (- bal (car args)))]
        
        ; if the action is deposit, I add the amount to the balance
        [(equal? action 'deposit) (set! bal (+ bal (car args)))]))))

; examples

(define acc (make-account 100))
(acc 'balance) ; should return 100
(acc 'deposit 50)
(acc 'balance) ; should return 150
(acc 'withdraw 30)
(acc 'balance) ; should return 120
