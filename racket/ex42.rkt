#lang racket

#|
Exercise 42: Implement my-foldl (Fold Left)

Description: Implement the foldl (or fold-left) function. Unlike foldr, foldl processes elements from left to right and is naturally tail-recursive.
E.g.: (my-foldl (lambda (acc x) (cons x acc)) '() '(1 2 3)) should return (3 2 1).
Learning Goal: Understand the difference between foldl and foldr and see how foldl's structure is inherently iterative and efficient.
|#

(define (my-foldl procedure accum init)
  (define (my-foldl-helper val acc)
    (if (empty? val)
      acc
      (my-foldl-helper (cdr val) (procedure acc (car val)))))
  (my-foldl-helper init accum))
