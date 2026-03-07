;; Defines a new piece of syntax (a macro) named let**.
(define-syntax let**
  ;; Specifies that this is a pattern-matching macro.
  ;; `def:` is treated as a special keyword, not a variable to be matched.
  (syntax-rules (def:)

    ;; --- PATTERN 1: Base Case for an Inherited Binding ---
    ;; This pattern is intended to match when there is only ONE binding left, and it's an inherited one like `[var]`.
    ;; NOTE: The syntax `(var)` is incorrect; it should be `([var])` to match a binding.
    ;; `istr` is also non-standard and should be `body`.
    ((_ def: v (var) istr ...)
      ;; This is the expansion for Pattern 1.
      ;; It uses a common macro trick: `((lambda (arg) body) value)` is equivalent to `(let ([arg value]) body)`.
      ;; Here, it binds `var` to `v` (the value inherited from the previous step).
      ;; Then, it executes the body of the let (`istr ...`).
      ((lambda (var) istr ...) v))


    ;; --- PATTERN 2: Base Case for an Explicit Binding ---
    ;; This pattern is intended to match when there is only ONE binding left, and it's an explicit one like `[var val]`.
    ;; NOTE: The syntax `((var val))` is incorrect; it should be `([var val])`.
    ((_ def: v ((var val)) istr ...)
      ;; This is the expansion for Pattern 2.
      ;; It binds `var` to its own explicit `val`.
      ;; The inherited value `v` is ignored in this step.
      ;; Then, it executes the body of the let (`istr ...`).
      ((lambda (var) istr ...) val))


    ;; --- PATTERN 3: Recursive Step for an Explicit Binding ---
    ;; This pattern matches when the first binding is explicit (`[var val]`) and there are more bindings (`. rest`).
    ;; NOTE: The syntax `((var val) . rest)` is incorrect; it should be `([var val] . rest)`.
    ((_ def: v ((var val) . rest) istr ...)
      ;; This is the expansion for Pattern 3.
      ;; It creates a `let` binding for the current `var` to its given `val`.
      ;; Inside this `let`, it makes a RECURSIVE call to `let**`.
      ;; CRITICAL: The recursive call `(let** def: val rest istr ...)` passes `val` as the new accumulator.
      ;; This is how the "last known value" is updated for the next step in the recursion.
      ((lambda (var)
         (let** def: val rest istr ...))
       val))


    ;; --- PATTERN 4: Recursive Step for an Inherited Binding ---
    ;; This pattern matches when the first binding is inherited (`[var]`) and there are more bindings (`. rest`).
    ;; NOTE: The syntax `(var . rest)` is incorrect; it should be `([var] . rest)`.
    ((_ def: v (var . rest) istr ...)
      ;; This is the expansion for Pattern 4.
      ;; It creates a `let` binding for the current `var` to the inherited value `v`.
      ;; Inside this `let`, it makes a RECURSIVE call to `let**`.
      ;; CRITICAL: The recursive call `(let** def: v rest istr ...)` passes the SAME `v` to the next step.
      ;; This is because this binding did not define a new value, so the old inherited value must be passed along.
      ((lambda (var)
         (let** def: v rest istr ...))
       v))))


; TODO: TO REVIEW THIS
