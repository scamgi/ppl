#lang racket

#|
**Exercise 2: List Length**
*   **Description:** Without using the built-in `length` function, write a recursive function `my-length` that counts the number of elements in a list.
*   **E.g.:** `(my-length '(a b c))` should return `3`.
*   **Learning Goal:** Reinforce the base case (`null?`) and recursive step pattern.
|#

#|
If the list is empty, I return 0, otherwise I return 1 + the function with the rest of the list.
|#

(define (my-length l)
  (if (empty? l) 0 (+ 1 (my-length (cdr l)))))

(my-length '(a b c))     ; -> (+ 1 (+ 1 (+ 1 0))) which is 3
(my-length '(1 2 3 4 5)) ; -> 5
(my-length '())          ; -> 0
