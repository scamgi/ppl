#lang racket

#|
Exercise 15: depth-encode (from PPL2021.02.08)

Description: Write the function depth-encode. It takes a deep list and returns a flat list where each element is paired with its nesting level.
E.g.: (depth-encode '(1 (2 3) 4)) should return ((0 . 1) (1 . 2) (1 . 3) (0 . 4)).
Learning Goal: Apply the skills of tracking state (the current depth) through recursion on a nested structure. This is your first direct practice on a real exam problem.
|#

; (define (depth-encode a-list)
;   (cond
;     ; base case
;     [(not (list? a-list)) (cons 0 a-list)]

;     ; list empty case
;     [(empty? a-list) null]
    
;     ; else case
;     [else ()]))

#|
(define (depth-encode L)
  (define (helper a-list depth)
    (cond
      ; base case: a-list is empty
      [(empty? a-list) '()]
      
      ; the item is not a list, therefore is a number or something else
      [(not (list? a-list)) (cons depth a-list)]
      
      ;else case: this is a nasted list
      [else (append (helper (car a-list) (+ depth 1)) (helper (cdr a-list) depth))]))
  (helper L 0))
|#

(define (depth-encode L)
  (define (helper a-list depth)
    (cond
      ;; Case 1: The list is empty. We are done.
      [(empty? a-list) '()]

      ;; Case 2: The first element is a list.
      ;; We must recursively process the sublist (at depth+1) and the rest
      ;; of the list (at the same depth), and append the results.
      [(list? (car a-list))
       (append (helper (car a-list) (+ depth 1))
               (helper (cdr a-list) depth))]
      
      ;; Case 3: The first element is an atom.
      ;; Create the pair for this atom and cons it onto the result
      ;; of processing the rest of the list.
      [else
       (cons (cons depth (car a-list))
             (helper (cdr a-list) depth))]))

  ;; Initial call to the helper function starts at depth 0.
  ;; However, the original function could be called with an atom.
  ;; We handle that case here.
  (if (list? L)
      (helper L 0)
      ;; This part is not in the spec, but makes the function robust.
      ;; The spec assumes the top-level is always a list.
      '()))

;; --- Examples ---
(displayln "Example 1:")
(depth-encode '(1 (2 3) 4))
; Expected output: '((0 . 1) (1 . 2) (1 . 3) (0 . 4))

(displayln "Example 2: More deeply nested list")
(depth-encode '(a (b (c) d) e))
; Expected output: '((0 . a) (1 . b) (2 . c) (1 . d) (0 . e))

(displayln "Example 3: Empty list")
(depth-encode '())
; Expected output: '()

(displayln "Example 4: List with an empty sublist")
(depth-encode '(1 () 2))
; Expected output: '((0 . 1) (0 . 2))
