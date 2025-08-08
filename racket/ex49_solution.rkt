#lang racket

#|
Exercise 49: fmap for the Expr ADT (from PPL2024.02.02)
...
|#

;; --- Constructors ---
(define (make-var name)
  (list 'Var name))
(define (make-val val)
  (list 'Val val))
(define (make-op left-expr right-expr)
  (list 'Op left-expr right-expr))

;; --- Predicates (Corrected and Robust) ---
(define (var? item)
  (and (pair? item) (eq? (car item) 'Var) (= (length item) 2)))
(define (val? item)
  (and (pair? item) (eq? (car item) 'Val) (= (length item) 2)))
(define (op? item)
  (and (pair? item) (eq? (car item) 'Op) (= (length item) 3)))

;; --- Accessors (More Specific Names) ---
(define (get-var-name v) (cadr v))
(define (get-val-value v) (cadr v))
(define (get-left-expr e) (cadr e))
(define (get-right-expr e) (caddr e))

;; --- fmap (Corrected Logic) ---
(define (fmap procedure expr)
  (cond
    ; Case 1: If it's a Var, apply the procedure to its content.
    [(var? expr)
     (make-var (procedure (get-var-name expr)))]

    ; Case 2: If it's a Val, do nothing. Return it as is.
    [(val? expr)
     expr]

    ; Case 3: If it's an Op, recurse on both children.
    [(op? expr)
     (make-op (fmap procedure (get-left-expr expr))
              (fmap procedure (get-right-expr expr)))]

    [else (error "fmap: invalid expression" expr)]))


;; --- Test Case from the Exercise Description ---
(define my-expr
  (make-op (make-var "a") (make-val 5)))

(define add-bang
  (lambda (x) (string-append x "!")))

(define result (fmap add-bang my-expr))

(printf "Original Expression: ~s\n" my-expr)
(printf "Fmapped Expression:  ~s\n" result)

; Expected output:
; Original Expression: '(Op (Var "a") (Val 5))
; Fmapped Expression:  '(Op (Var "a!") (Val 5))
