#lang racket

#|
Exercise 50: >>= for the Expr ADT (from PPL2024.02.02)

Description: For the same Expr ADT, implement the monadic bind operator >>=. The >>= function takes an Expr and a procedure f. It applies f to the value inside a Var, and f is expected to return a new Expr. It should recursively apply itself to Ops and do nothing to Vals.
Learning Goal: Tackle the most difficult part of the exam problem, requiring a deep understanding of how Monads transform structures.
|#

; all written with AI

; --- Constructors (from Exercise 49) ---
(define (make-var a)   (list 'Var a))
(define (make-val n)   (list 'Val n))
(define (make-op e1 e2) (list 'Op e1 e2))

; --- Predicates (from Exercise 49) ---
(define (var? expr)   (and (list? expr) (eq? (car expr) 'Var)))
(define (val? expr)   (and (list? expr) (eq? (car expr) 'Val)))
(define (op? expr)    (and (list? expr) (eq? (car expr) 'Op)))

; --- Selectors (for accessing parts of the ADT) ---
(define (var-val expr)   (cadr expr))
(define (val-num expr)   (cadr expr))
(define (op-left expr)  (cadr expr))
(define (op-right expr) (caddr expr))

(define (expr-bind expr f)
  (cond
    ; Case 1: If the expression is a 'Val', do nothing.
    ; The bind operation propagates through it unchanged.
    [(val? expr)
     expr]

    ; Case 2: If the expression is a 'Var', apply the function 'f'.
    ; 'f' takes the raw value inside the Var and must return a new, complete Expr.
    [(var? expr)
     (f (var-val expr))]

    ; Case 3: If the expression is an 'Op', recursively call expr-bind on the
    ; left and right sub-expressions and then reconstruct the 'Op' node.
    [(op? expr)
     (make-op (expr-bind (op-left expr) f)
              (expr-bind (op-right expr) f))]

    ; Else case for handling non-Expr data
    [else expr]))


(define my-expr (make-op (make-var "x") (make-op (make-val 5) (make-var "y"))))


(define (substitute-x v)
  (if (equal? v "x")
      (make-val 100)
      (make-var v)))

