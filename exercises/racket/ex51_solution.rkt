#lang racket

;; -----------------------------------------------------------------------------
;; Part 2: The Recursive Helper Macro (`let**-impl`)
;;
;; This is the core of the implementation. It takes three arguments:
;;   1. `last-val`: The identifier holding the value of the previous binding.
;;   2. `(bindings ...)`: The list of remaining bindings to process.
;;   3. `(body ...)`: The final code to execute.
;;------------------------------------------------------------------------------
(define-syntax let**-impl
  (syntax-rules ()

    ; Base Case: If there are no more bindings, we are done.
    ; Just expand to the body of the let**.
    [(_ last-val () body ...)
     (begin body ...)]

    ; Recursive Case 1: An inherited binding of the form `[var]`.
    ; It should inherit its value from the `last-val` identifier.
    [(_ last-val ([var] bindings-rest ...) body ...)
     ; Expand into a `let` that binds `var` to `last-val`.
     (let ([var last-val])
       ; Then, recursively call `let**-impl` on the rest of the bindings.
       ; The *new* last-val for the next iteration is now `var` itself.
       (let**-impl var (bindings-rest ...) body ...))]

    ; Recursive Case 2: An explicit binding of the form `[var val]`.
    ; This is the standard let* behavior.
    [(_ last-val ([var val] bindings-rest ...) body ...)
     ; Expand into a `let` that binds `var` to its given `val`.
     (let ([var val])
       ; Then, recursively call `let**-impl` on the rest of the bindings.
       ; The *new* last-val for the next iteration is this `var`.
       (let**-impl var (bindings-rest ...) body ...))]
    ))


;; -----------------------------------------------------------------------------
;; Part 1: The Public-Facing Macro (`let**`)
;;
;; This is the macro the user interacts with. Its job is to set up the
;; initial state and call the helper macro `let**-impl`.
;;------------------------------------------------------------------------------
(define-syntax let**
  (syntax-rules (def:)

    ; Pattern 1: The user provides a `def:` default value.
    [(let** ([def: default-val] bindings ...) body ...)
     ; Create a temporary `let` to hold the default value.
     (let ([initial-last-val default-val])
       ; Start the recursion, seeding it with this initial value.
       (let**-impl initial-last-val (bindings ...) body ...))]

    ; Pattern 2: The user does *not* provide a `def:`.
    ; In this case, the very first binding MUST have an explicit value.
    [(let** ([var val] bindings-rest ...) body ...)
     ; Create a `let` for the first binding.
     (let ([var val])
       ; Start the recursion. The "last value" is now `var` itself.
       (let**-impl var (bindings-rest ...) body ...))]

    ; Note: If the user provides `(let** ([var] ...) ...)` without a `def:`,
    ; neither of the patterns above will match, and Racket will correctly
    ; report a syntax error, as desired.
    ))