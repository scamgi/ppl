#lang racket

(define (depth-encode ls)
  ;; Define a local helper function to handle the recursion.
  ;; This is a common and useful pattern in Racket.
  (define (enc-aux l)
    (cond
      ;; BASE CASE: If the list is empty, there is nothing to do. Return it.
      [(null? l) l]

      ;; RECURSIVE CASE 1: The first element of the list is another list.
      [(list? (car l))
       ;; This is the most complex part. We need to do two things:
       ;; 1. Process the sublist `(car l)`.
       ;; 2. Process the rest of the list `(cdr l)`.
       ;; We then combine the results with `append`.
       (append
        ;; Part 1: Process the sublist.
        ;; First, we recursively call `enc-aux` on the sublist `(car l)`.
        ;; This returns a list of pairs, e.g., '((0 . 2) (0 . 3)).
        ;; Notice the depths are all relative to the sublist (i.e., they start at 0).
        ;; We then use `map` to go over this list of pairs and "fix" the depth.
        ;; The lambda function takes a pair `nx`, adds 1 to its depth `(car nx)`,
        ;; and creates a new pair with the correct depth.
        (map (lambda (nx) (cons (+ (car nx) 1) (cdr nx)))
             (enc-aux (car l)))
        
        ;; Part 2: Process the rest of the list.
        ;; We make a separate recursive call for the rest of the list.
        (enc-aux (cdr l)))]

      ;; RECURSIVE CASE 2: The first element is an atom (not a list).
      [else
       ;; Create a pair with depth 0 and the atom `(car l)`.
       ;; Note: This always uses depth 0. The depth is corrected by the `map`
       ;; in the caller function if this atom is inside a nested list.
       (cons (cons 0 (car l))
             (enc-aux (cdr l)))]))
  
  ;; Start the process by calling the helper function on the initial list.
  (enc-aux ls))


;; --- Examples ---
(displayln "Example 1:")
(depth-encode '(1 (2 3) 4))
; Expected output: '((0 . 1) (1 . 2) (1 . 3) (0 . 4))

(displayln "Example 2: More deeply nested list")
(depth-encode '(a (b (c) d) e))
; Expected output: '((0 . a) (1 . b) (2 . c) (1 . d) (0 . e))