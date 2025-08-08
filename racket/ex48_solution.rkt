#lang racket



; (ADT definitions from previous exercise are assumed to be here)
(define (make-leaf value) (list 'Leaf value))
(define (make-node left right) (list 'Node left right))
(define (leaf? item) (and (pair? item) (eq? (car item) 'Leaf) (= (length item) 2)))
(define (node? item) (and (pair? item) (eq? (car item) 'Node) (= (length item) 3)))
(define (leaf-value a-leaf) (cadr a-leaf))
(define (node-left a-node) (cadr a-node))
(define (node-right a-node) (caddr a-node))


(define (fold-tree hand-leaf comb-nodes tree)
  (cond
    [(leaf? tree)
     ; Base Case: Apply the leaf-handling function to the *value* inside the leaf.
     (hand-leaf (leaf-value tree))]
    [(node? tree)
     ; Recursive Step:
     ; 1. Fold the left and right subtrees to get their results.
     (let ((left-result (fold-tree hand-leaf comb-nodes (node-left tree)))
           (right-result (fold-tree hand-leaf comb-nodes (node-right tree))))
       ; 2. Combine those results using the node-combining function.
       (comb-nodes left-result right-result))]
    [else (error "fold-tree: invalid tree structure" tree)]))


;; --- Example Usage ---

(define my-tree
  (make-node
   (make-leaf 10)
   (make-node
    (make-leaf 5)
    (make-leaf 2))))

;; Example 1: Sum all the values in the tree.
; - For a leaf, the result is just its value.
; - For a node, the result is the sum of the results from its children.
(define sum (fold-tree (lambda (v) v) + my-tree))
(printf "Sum of the tree: ~s\n" sum) ; -> 17

;; Example 2: Find the product of all values in the tree.
(define product (fold-tree (lambda (v) v) * my-tree))
(printf "Product of the tree: ~s\n" product) ; -> 100

;; Example 3: Re-implement map-tree using fold-tree.
;; This shows the power of fold!
; - For a leaf, the result is a new leaf with the value squared.
; - For a node, the result is a new node built from the results of the children.
(define (square x) (* x x))
(define mapped-tree
  (fold-tree
   (lambda (v) (make-leaf (square v))) ; leaf-handler
   (lambda (l r) (make-node l r))      ; node-combiner
   my-tree))

(printf "Mapped tree: ~s\n" mapped-tree)
; -> '(Node (Leaf 100) (Node (Leaf 25) (Leaf 4)))
