#lang racket

#|
Exercise 20: One-Pass fold-left-right (from PPL2023.06.12)

Description: Write a function that computes both fold-left and fold-right in a single pass over the list, returning the results in a pair.
E.g.: (fold-left-right string-append "" '("a" "b" "c")) should return the pair ("cba" . "abc").
Learning Goal: Learn to manage multiple accumulators in a single recursive helper function for efficiency, a more advanced but powerful technique.
|#

; this is not correct because I need to do it in a single pass
#|
(define (fold-left-right procedure initial-value L)
  (let ((x (foldl procedure initial-value L))
        (y (foldr procedure initial-value L)))
    (cons x y)))

; examples

(displayln (fold-left-right string-append "" '("a" "b" "c"))) ; should return ("cba" . "abc")
|#

; wrong again
#|
(define (fold-left-right procedure initial-value L)

  ; if the initial value is not a pair, make sure it is a pair
  (cond
    [(not (pair? initial-value)) (set! initial-value '('() '()))])

  (cond
    ; base case
    [(empty? L) initial-value]

    ; else
    [else
      (let ((x (procedure (car L) (car initial-value)))
            (y (procedure (cdr L) (cdr initial-value))))
        (fold-left-right procedure (cons x y) (cdr L)))]))

; examples

(displayln (fold-left-right string-append "" '("a" "b" "c"))) ; should return ("cba" . "abc")
|#

(define (fold-left-right procedure initial-value L)
  ;; A helper function is the standard way to solve this.
  ;; It does the actual recursion.
  (define (helper lst)
    (if (empty? lst)
        ;; 1. Base Case: When the end of the list is reached,
        ;;    return a pair of the initial values.
        (cons initial-value initial-value)

        ;; 2. Recursive Step
        (let* (
               ; Get the current element
               (x (car lst))
               ; Recurse on the REST of the list FIRST.
               ; `p` will be the pair of results for the rest of the list.
               (p (helper (cdr lst)))
              )
          ;; 3. After the recursive call returns, combine the results.
          (let ((left-fold-res (car p))
                (right-fold-res (cdr p)))
            ; The left-fold result is built right-to-left.
            ; The right-fold result is built left-to-right.
            (cons (procedure left-fold-res x)
                  (procedure x right-fold-res))))))

  ;; Start the process and then reverse the final pair to match the example's output.
  (let ((result (helper L)))
    (cons (cdr result) (car result))))


;; Let's trace `(fold-left-right string-append "" '("a" "b" "c"))`
;; 1. helper('("a" "b" "c")) calls helper('("b" "c"))
;; 2. helper('("b" "c")) calls helper('("c"))
;; 3. helper('("c")) calls helper('())
;; 4. helper('()) returns ("" . "")
;; 5. helper('("c")) receives ("" . ""). x="c". It computes and returns:
;;    (cons (string-append "" "c") (string-append "c" "")) -> ("c" . "c")
;; 6. helper('("b" "c")) receives ("c" . "c"). x="b". It computes and returns:
;;    (cons (string-append "c" "b") (string-append "b" "c")) -> ("cb" . "bc")
;; 7. helper('("a" "b" "c")) receives ("cb" . "bc"). x="a". It computes and returns:
;;    (cons (string-append "cb" "a") (string-append "a" "bc")) -> ("cba" . "abc")
;; 8. The final result is ("cba" . "abc"), which is correct.

(displayln (fold-left-right string-append "" '("a" "b" "c")))
; Correct Output: ("cba" . "abc")
