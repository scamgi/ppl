#lang racket

#|
Exercise 45: Deep List Equality

Description: Write a function `deep-equal?` that takes two deep lists and
returns #t if they have the same structure and the same atomic values,
and #f otherwise.
|#

; everything done by gemini

(define (deep-equal? item1 item2)
  (cond
    ; The recursive case: If both items are pairs (non-empty lists),
    ; we must compare their first parts AND their remaining parts.
    [(and (pair? item1) (pair? item2))
     (and (deep-equal? (car item1) (car item2))
          (deep-equal? (cdr item1) (cdr item2)))]

    ; The base case: If they are not both pairs, then they are only
    ; equal if the built-in `equal?` says they are. This correctly
    ; handles two atoms (e.g., 5 and 5), an atom and a list,
    ; or two empty lists.
    [else
     (equal? item1 item2)]))

;; --- Test Cases ---

;; Test cases from the exercise description
(printf "Test Case 1: (deep-equal? '(1 (2)) '(1 (2))) -> ~s\n"
        (deep-equal? '(1 (2)) '(1 (2)))) ; Expected: #t

(printf "Test Case 2: (deep-equal? '(1 (2)) '(1 2)) -> ~s\n"
        (deep-equal? '(1 (2)) '(1 2)))   ; Expected: #f

;; More test cases to verify correctness
(printf "Test Case 3: (deep-equal? 'a 'a) -> ~s\n"
        (deep-equal? 'a 'a))             ; Expected: #t

(printf "Test Case 4: (deep-equal? '() '()) -> ~s\n"
        (deep-equal? '() '()))           ; Expected: #t

(printf "Test Case 5: (deep-equal? '(1 (2 (3))) '(1 (2 (3)))) -> ~s\n"
        (deep-equal? '(1 (2 (3))) '(1 (2 (3))))) ; Expected: #t

(printf "Test Case 6: (deep-equal? '(1 (2 (3))) '(1 (2 (4)))) -> ~s\n"
        (deep-equal? '(1 (2 (3))) '(1 (2 (4))))) ; Expected: #f

(printf "Test Case 7: (deep-equal? '(a b) '(a c)) -> ~s\n"
        (deep-equal? '(a b) '(a c)))     ; Expected: #f

(printf "Test Case 8: (deep-equal? '(a (b)) 'a) -> ~s\n"
        (deep-equal? '(a (b)) 'a))       ; Expected: #f

