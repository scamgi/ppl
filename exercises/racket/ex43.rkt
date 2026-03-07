#lang racket

#|
Exercise 43: Palindrome Check

Description: Write a tail-recursive function is-palindrome? that checks if a list is the same forwards and backwards.
E.g.: (is-palindrome? '(r a c e c a r)) should return #t.
Learning Goal: Apply tail recursion to a problem that isn't a simple accumulation, possibly by comparing the list to its reverse or using a more complex two-pointer recursive approach.
|#

(define (is-palindrome? lst)
  (cond
    [(or (empty? lst) (= 1 (length lst))) #t]
    [(not (eq? (first lst) (last lst))) #f]
    [else (is-palindrome? (reverse (cdr (reverse (cdr lst)))))]))

(define fi1 '(a b c b a))
(define fi2 '(a b c c b a))
(define fi3 '())
(define fi4 '(b))
(define fi5 '(a b c d b a)) ; #f
(define fi6 '(a b b b)) ; #f

(is-palindrome? fi1)
(is-palindrome? fi2)
(is-palindrome? fi3)
(is-palindrome? fi4)
(is-palindrome? fi5)
(is-palindrome? fi6)
