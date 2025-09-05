#|
Exercise 55: define-dispatcher (from PPL2022.07.06)

Description: Implement the define-dispatcher macro. This macro should automatically generate the dispatcher lambda for an object, taking a list of method names and an optional parent object.
Learning Goal: This is a "macro-generating" macro. It requires manipulating lists of symbols within the macro to generate a complex case statement, representing the peak of macro difficulty seen in the exams.
|#

(define-syntax define-dispatcher
    (syntax-rules
        [(_ )]))