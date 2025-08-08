#lang racket

#|
Exercise 46: Constructors and Predicates for Binary Trees

Description: Let's model a binary tree where (Leaf 5) is ' (Leaf 5)
and (Node (Leaf 1) (Leaf 2)) is '(Node (Leaf 1) (Leaf 2)). Write the
constructor functions make-leaf, make-node and the predicate functions
leaf? and node?.
Learning Goal: Establish the core pattern for representing an Algebraic
Data Type (ADT) in Scheme.
|#

;; --- Constructors ---
;; Create the list structure with the appropriate tag.

(define (make-leaf value)
  (list 'Leaf value))

(define (make-node left right)
  (list 'Node left right))

;; --- Predicates ---
;; Check if an item is a valid ADT of a certain type.
;; A robust predicate checks:
;; 1. Is it a list? (Using pair?)
;; 2. Does it have the correct tag?
;; 3. Does it have the correct number of elements?

(define (leaf? item)
  (and (pair? item)
       (eq? (car item) 'Leaf)
       (= (length item) 2)))

(define (node? item)
  (and (pair? item)
       (eq? (car item) 'Node)
       (= (length item) 3)))

;; --- Accessors (Selectors) ---
;; It's also good practice to write functions to get data *out* of your structure.

(define (leaf-value a-leaf)
  (cadr a-leaf)) ; (car (cdr a-leaf))

(define (node-left a-node)
  (cadr a-node)) ; (car (cdr a-node))

(define (node-right a-node)
  (caddr a-node)) ; (car (cdr (cdr a-node)))


;; --- Example Usage ---

(define my-tree
  (make-node
   (make-leaf 10)
   (make-node
    (make-leaf 20)
    (make-leaf "hello"))))

(displayln my-tree) ;  '(Node (Leaf 10) (Node (Leaf 20) (Leaf "hello")))

(printf "Is the whole thing a node? ~s\n" (node? my-tree)) ; -> #t
(printf "Is the whole thing a leaf? ~s\n" (leaf? my-tree)) ; -> #f

(define left-child (node-left my-tree))
(printf "Left child is: ~s\n" left-child) ; -> '(Leaf 10)
(printf "Is the left child a leaf? ~s\n" (leaf? left-child)) ; -> #t
(printf "The value of the left child is: ~s\n" (leaf-value left-child)) ; -> 10