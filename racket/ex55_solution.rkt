(define-syntax define-dispatcher
  (syntax-rules ()

    ; Pattern 1: Handles the case WITH a parent object.
    ; (define-dispatcher (method-name ...) parent)
    [(define-dispatcher (method-name ...) parent)
     (lambda (msg . args)
       (case msg
         ; For each 'method-name' in the input list, this line is generated.
         ; E.g., if (method1 method2) is the input, it creates:
         ;   [(method1) (apply method1 args)]
         ;   [(method2) (apply method2 args)]
         [(method-name) (apply method-name args)] ...

         ; The 'else' clause handles any message not matched above.
         ; It delegates the message and its arguments to the parent object.
         [else (apply parent msg args)]))]

    ; Pattern 2: Handles the case WITHOUT a parent object.
    ; (define-dispatcher (method-name ...))
    [(define-dispatcher (method-name ...) )
     (lambda (msg . args)
       (case msg
         ; This part works identically to the pattern above.
         [(method-name) (apply method-name args)] ...

         ; The 'else' clause here is different. With no parent to delegate to,
         ; it raises an error for any unrecognized message.
         [else (error "Unknown message:" msg)]))]))


; First, define some "methods". These are just regular functions.
(define x 10)
(define y 20)
(define color "red")

(define (get-x) x)
(define (set-x! new-x) (set! x new-x))
(define (get-y) y)
(define (get-color) color)

; --- Parent Object ---
; Create a "parent" object that only knows about color.
(define color-object
  (define-dispatcher (get-color)))

; --- Child Object ---
; Create a "child" point object that knows about x and y,
; and delegates other messages to its parent, 'color-object'.
(define point-object
  (define-dispatcher (get-x set-x! get-y) color-object))

; --- Using the Objects ---

; Message handled by the child
(displayln (point-object 'get-x))  ; Output: 10

; Another message handled by the child
(point-object 'set-x! 99)
(displayln (point-object 'get-x))  ; Output: 99

; Message NOT handled by child, so it's delegated to the parent
(displayln (point-object 'get-color)) ; Output: "red"

; Message that neither object handles
(displayln (point-object 'get-z)) ; Error: Unknown message: get-z
                                  ; (This error comes from the parent)
