#lang racket

#|
Exercise 49: fmap for the Expr ADT (from PPL2024.02.02)

Description: Model the Expr data type: data Expr a = Var a | Val Int | Op (Expr a) (Expr a). Write constructors make-var, make-val, make-op and a fmap function that applies a procedure only to the Var constructors.
E.g.: (fmap (lambda (x) (string-append x "!")) '(Op (Var "a") (Val 5))) should return '(Op (Var "a!") (Val 5)).
Learning Goal: Directly practice a key part of an exam question, focusing on functorial application over a custom ADT.
|#

(define (make-var name)
  (list 'Var name))

(define (make-val val)
  (list 'Val val))

(define (make-op left-expr right-expr)
  (list 'Op left-expr right-expr))

(define (var? v) (and (= 2 (length v)) (equal? 'Var (car v))))
(define (val? v) (and (= 2 (length v)) (equal? 'Val (car v))))
(define (op? e) (and (= 3 (length v))
                       (equal? 'Op (car v))
                       (or (var? left-expr) (val? left-expr) (op? left-expr))
                       (or (var? right-expr) (val? right-expr) (op? right-expr))))


(define (get-val val) (cadr val))
(define (get-left-expr e) (cadr e))
(define (get-right-expr e) (caddr e))


(define (fmap procedure expr)
  (cond
    [(var? expr) expr]
    [(val? expr) (make-val (procedure (get-val expr)))]
    [(op? expr) (make-op (fmap procedure (get-left-expr expr)) (fmap procedure (get-right-expr expr)))]
    [else (error "invalid expression")]))

