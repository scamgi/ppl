#lang racket

#|
Exercise 48: fold-tree

Description: Write a fold-tree function. It should take two procedures (one for handling leaves, one for combining results from nodes) and a tree, and reduce the tree to a single value.
Learning Goal: Implement the catamorphism for a tree structure, the most powerful way to process it.
|#

(define (make-leaf value)
  (list 'Leaf value))

(define (make-node left right)
  (list 'Node left right))
(define (leaf? item)
  (and (pair? item)
       (eq? (car item) 'Leaf)
       (= (length item) 2)))

(define (node? item)
  (and (pair? item)
       (eq? (car item) 'Node)
       (= (length item) 3)))

(define (leaf-value a-leaf)
  (cadr a-leaf)) ; (car (cdr a-leaf))

(define (node-left a-node)
  (cadr a-node)) ; (car (cdr a-node))

(define (node-right a-node)
  (caddr a-node)) ; (car (cdr (cdr a-node)))


(define (map-tree procedure tree)
  (cond
    [(leaf? tree) (list 'Leaf (procedure (leaf-value tree)))]
    [(node? tree) (list 'Node (map-tree procedure (node-left tree)) (map-tree procedure (node-right tree)))]
    [else (error "map-tree: invalid tree structure" tree)]))

(define (fold-tree hand-leaf comb-nodes tree)
  (cond
    [(leaf? tree) (hand-leaf tree)]
    [(node? tree) (comb-nodes tree)]
    [else (error "invalid tree structure")]))

