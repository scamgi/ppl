#lang racket

#|
Exercise 46: Constructors and Predicates for Binary Trees

Description: Let's model a binary tree where (Leaf 5) is ' (Leaf 5) and (Node (Leaf 1) (Leaf 2)) is '(Node (Leaf 1) (Leaf 2)). Write the constructor functions make-leaf, make-node and the predicate functions leaf? and node?.
Learning Goal: Establish the core pattern for representing an Algebraic Data Type (ADT) in Scheme.
|#

(define (make-leaf num)
  '(Leaf ,num))

(define (make-node left right)
  '(Node ,left ,right))

(define (leaf? lst)
  (and (equal? 'Leaf (car lst)) (number? (car (cdr lst)))))

(define (node? lst)
  (cond
    [(not (equal? 'Node (car lst))) #f]
    [else
      (let ((left (car (cdr lst))) (right (car (cddr lst))))
        )]))