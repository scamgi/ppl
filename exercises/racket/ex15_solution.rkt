#lang racket


(define (depth-encode a-list)
  ;; For problems involving nested structures where a state (like depth) must be
  ;; maintained, a common and powerful pattern is to use a helper function.
  ;; This helper function takes the data to process and the current state as arguments.
  (define (helper lst depth)
    (cond
      ;; Base Case: If the current list is empty, there are no elements to encode,
      ;; so we return an empty list.
      [(empty? lst) '()]

      ;; Recursive Step: The list is not empty, so we process its first element
      ;; and the rest of the list separately.
      [else
       (let ([first-element (car lst)]
             [rest-of-list (cdr lst)])
         
         (if (list? first-element)
             ;; Case 1: The first element is itself a list.
             ;; We must do two things:
             ;; 1. Recursively call the helper on the sublist, INCREMENTING the depth.
             ;; 2. Recursively call the helper on the rest of the main list at the SAME depth.
             ;; We then `append` the two resulting lists of pairs together to keep the output flat.
             (append (helper first-element (+ depth 1))
                     (helper rest-of-list depth))
             
             ;; Case 2: The first element is an atom (not a list).
             ;; This is what we want to encode.
             ;; 1. Create the pair of (depth . atom).
             ;; 2. Recursively process the rest of the list at the current depth.
             ;; 3. `cons` the new pair onto the front of the list returned by the recursion.
             (cons (cons depth first-element)
                   (helper rest-of-list depth))))]))

  ;; The main `depth-encode` function starts the process by calling the helper
  ;; with the initial list and a starting depth of 0.
  (helper a-list 0))

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
