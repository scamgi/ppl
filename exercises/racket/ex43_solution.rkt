(define (is-palindrome-efficient? lst)
  ; Helper function that does the work. It is tail-recursive.
  (define (iter l1 l2)
    (cond
      ; If we've reached the end of the lists, they were equal.
      [(empty? l1) #t]
      ; If a pair of elements don't match, it's not a palindrome.
      [(not (equal? (first l1) (first l2))) #f]
      ; Otherwise, continue with the rest of the lists.
      [else (iter (cdr l1) (cdr l2))]))

  ; Start the process by comparing the original list with its reverse.
  (iter lst (reverse lst)))
