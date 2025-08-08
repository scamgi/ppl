#lang racket

#|
Exercise 47: map-tree

Description: Using the tree structure from the previous exercise, write a map-tree function that takes a procedure and a tree, and applies the procedure to every value in the leaves, returning a new tree with the same structure.
Learning Goal: Apply the recursive processing pattern to your custom ADT.
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




; examplessss

; Create a sample tree
(define my-tree
  (make-node
   (make-leaf 10)
   (make-node
    (make-leaf 5)
    (make-leaf 2))))

; Define a procedure to apply
(define (square x) (* x x))

; Map the procedure over the tree
(define new-tree (map-tree square my-tree))

(printf "Original Tree: ~s\n" my-tree)
(printf "New Tree:      ~s\n" new-tree)

; Expected output:
; Original Tree: '(Node (Leaf 10) (Node (Leaf 5) (Leaf 2)))
; New Tree:      '(Node (Leaf 100) (Node (Leaf 25) (Leaf 4)))
