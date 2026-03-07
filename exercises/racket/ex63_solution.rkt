#lang racket

;; Helper function:
;; Takes a list like '(1 1 2 3) and returns two values:
;; 1. The first group: '(1 1)
;; 2. The rest of the list: '(2 3)
(define (take-first-group lst)
  (let ([first-elem (car lst)])
    ; Use a local tail-recursive loop to build the first group
    (let loop ([current-group '()]
               [remaining-lst lst])
      (cond
        ; Stop if the list is empty or the next element is different
        [(or (empty? remaining-lst)
             (not (eq? (car remaining-lst) first-elem)))
         ; Return the group we built (reversed) and the list that's left
         (values (reverse current-group) remaining-lst)]
        
        ; Otherwise, add the current element to our group and continue
        [else
         (loop (cons (car remaining-lst) current-group)
               (cdr remaining-lst))])))
)


(define (group-consecutive lst)
  (if (empty? lst)
      '() ; Base case: if the list is empty, we're done.
      (let-values ([(current-group rest-of-list) (take-first-group lst)])
        ; 1. Get the first group (e.g., '(1 1)) and the rest (e.g., '(2 3 3 ...))
        ; 2. Cons the group we found onto the result of processing the rest of the list.
        (cons current-group (group-consecutive rest-of-list)))))


; --- Examples ---
(group-consecutive '(1 1 2 3 3 3 1 1))
; Expected: '((1 1) (2) (3 3 3) (1 1))

(group-consecutive '())
; Expected: '()

(group-consecutive '(5 5 5 5))
; Expected: '((5 5 5 5))
