Of course. Based on a thorough analysis of the Racket (Scheme) exercises from the provided exams, I've identified the core concepts you need to master. The problems consistently test your understanding of:

1.  **List Recursion:** The absolute foundation. Almost every problem involves processing a list recursively.
2.  **Higher-Order Functions:** Using and, more importantly, understanding how to implement functions like `map`, `filter`, and `fold`.
3.  **Complex/Nested Data Structures:** Applying recursion to lists that contain other lists (i.e., trees).
4.  **Macros:** Creating your own syntax and control structures.
5.  **Continuations:** Using `call/cc` for advanced, non-local control flow like `break` or `return`.
6.  **State and Closures:** Using `set!` and `lambda` to create objects with internal state.

The following 20 exercises form the first part of a 100-exercise course designed to build these skills from the ground up, preparing you for the complexity seen in the exams.

***

### **A Course in Racket for Programming Language Principles**

#### **Part 1: The Foundation of List Processing (Exercises 1-20)**

This initial set of exercises will ensure you have a rock-solid foundation in list manipulation, recursion, and the use of higher-order functions. Mastering these is non-negotiable for solving the exam problems.

---

#### **Module 1: Recursive Fundamentals**

**Exercise 1: Sum of a List**
*   **Description:** Write a recursive function `sum-list` that takes a list of numbers and returns their sum. An empty list should result in 0.
*   **E.g.:** `(sum-list '(1 2 3 4))` should return `10`.
*   **Learning Goal:** Master the most basic pattern of recursion over a list: processing the `car` and recurring on the `cdr`.

**Exercise 2: List Length**
*   **Description:** Without using the built-in `length` function, write a recursive function `my-length` that counts the number of elements in a list.
*   **E.g.:** `(my-length '(a b c))` should return `3`.
*   **Learning Goal:** Reinforce the base case (`null?`) and recursive step pattern.

**Exercise 3: Element Membership**
*   **Description:** Write a function `my-member?` that takes an element and a list and returns `#t` if the element is in the list, and `#f` otherwise.
*   **E.g.:** `(my-member? 'b '(a b c))` should return `#t`.
*   **Learning Goal:** Introduce conditional logic (`cond` or `if`) within the recursive structure.

**Exercise 4: Appending Lists**
*   **Description:** Without using `append`, write a recursive function `my-append` that takes two lists and returns a new list containing all elements of the first followed by all elements of the second.
*   **E.g.:** `(my-append '(1 2) '(3 4))` should return `(1 2 3 4)`.
*   **Learning Goal:** Understand how to reconstruct a list during the recursive process using `cons`.

**Exercise 5: Reversing a List**
*   **Description:** Write a function `my-reverse` that reverses a list. You may want to use a helper function with an accumulator.
*   **E.g.:** `(my-reverse '(1 2 3))` should return `(3 2 1)`.
*   **Learning Goal:** Introduce the powerful concept of an accumulator to build a result during recursion, which is essential for tail-recursive solutions.

---

#### **Module 2: Higher-Order Functions**

**Exercise 6: Simple Map**
*   **Description:** Write a function `square-all` that takes a list of numbers and returns a new list with each number squared.
*   **E.g.:** `(square-all '(1 2 3 4))` should return `(1 4 9 16)`.
*   **Learning Goal:** See the pattern of applying a transformation to every element, motivating the need for a generic `map`.

**Exercise 7: Implement `my-map`**
*   **Description:** Implement your own version of `map`. It should take a procedure and a list, and apply the procedure to every element of the list, returning a new list of the results.
*   **E.g.:** `(my-map (lambda (x) (* x 2)) '(10 20 30))` should return `(20 40 60)`.
*   **Learning Goal:** Abstract the transformation pattern into a higher-order function. This is a critical skill seen in many exam questions.

**Exercise 8: Simple Filter**
*   **Description:** Write a function `filter-even` that takes a list of numbers and returns a new list containing only the even numbers.
*   **E.g.:** `(filter-even '(1 2 3 4 5 6))` should return `(2 4 6)`.
*   **Learning Goal:** See the pattern of selecting elements based on a predicate, motivating the need for `filter`.

**Exercise 9: Implement `my-filter`**
*   **Description:** Implement your own version of `filter`. It should take a predicate (a function that returns `#t` or `#f`) and a list, and return a new list containing only the elements for which the predicate returns `#t`.
*   **E.g.:** `(my-filter odd? '(1 2 3 4 5))` should return `(1 3 5)`.
*   **Learning Goal:** Abstract the selection pattern into a higher-order function.

**Exercise 10: Implement `my-foldr` (Fold Right)**
*   **Description:** Implement the `foldr` (or `fold-right`) function. It takes a procedure, a base value, and a list. It combines the elements of the list from right to left.
*   **E.g.:** `(my-foldr cons '() '(1 2 3))` should be equivalent to `(cons 1 (cons 2 (cons 3 '())))`, returning `(1 2 3)`.
*   **Learning Goal:** Understand the fundamental "catamorphism" for lists, the most powerful list processing tool. Many other functions can be defined using `foldr`.

---

#### **Module 3: Tackling Nested Lists**

**Exercise 11: Count All Atoms**
*   **Description:** Write a function `deep-count` that takes a list which may contain other lists (a "deep list") and counts the total number of non-list atoms.
*   **E.g.:** `(deep-count '(1 (2 3) 4 ((5))))` should return `5`.
*   **Learning Goal:** Adapt the basic recursion pattern to handle nested structures by checking `(list? ...)` and making two recursive calls when a sub-list is found.

**Exercise 12: Flatten a List**
*   **Description:** Write a function `flatten` that takes a deep list and returns a single, "flat" list containing all the atoms in order.
*   **E.g.:** `(flatten '(1 (2 (3)) 4 (5 6)))` should return `(1 2 3 4 5 6)`.
*   **Learning Goal:** Practice combining results from nested recursive calls using `append`. This is a very common pattern.

**Exercise 13: Deep Map**
*   **Description:** Write a function `deep-map` that takes a procedure and a deep list. It should return a new deep list with the same structure, but with the procedure applied to every atom.
*   **E.g.:** `(deep-map (lambda (x) (* x x)) '(1 (2 3)))` should return `(1 (4 9))`.
*   **Learning Goal:** Combine the logic of `map` with deep recursion. This directly relates to the `multi-list->vector` problem (PPL20210120).

**Exercise 14: Depth of a List**
*   **Description:** Write a function `depth` that computes the maximum nesting level of a list. An atom or empty list has a depth of 0.
*   **E.g.:** `(depth '(1 (2) ((3))))` should return `3`.
*   **Learning Goal:** Practice using recursion to calculate a property of the structure itself, not just its elements.

**Exercise 15: `depth-encode` (from PPL2021.02.08)**
*   **Description:** Write the function `depth-encode`. It takes a deep list and returns a flat list where each element is paired with its nesting level.
*   **E.g.:** `(depth-encode '(1 (2 3) 4))` should return `((0 . 1) (1 . 2) (1 . 3) (0 . 4))`.
*   **Learning Goal:** Apply the skills of tracking state (the current depth) through recursion on a nested structure. This is your first direct practice on a real exam problem.

---

#### **Module 4: Variadic and Higher-Order Function Applications**

**Exercise 16: Function Composition**
*   **Description:** Write a function `compose` that takes two functions, `f` and `g`, and returns a new function that represents their composition, `f(g(x))`.
*   **E.g.:** `(define (add1 x) (+ x 1))` `(define (sqr x) (* x x))` `((compose sqr add1) 5)` should return `36`.
*   **Learning Goal:** Practice creating functions that return other functions (closures), a key concept.

**Exercise 17: `list-to-compose` (from PPL2022.06.16)**
*   **Description:** Define a pure function `list-to-compose` which takes a list of functions and returns their composition.
*   **E.g.:** `((list-to-compose (list sqr add1)) 5)` should return `36`.
*   **Learning Goal:** Combine `fold` with function composition to solve a real exam problem elegantly.

**Exercise 18: Variadic Functions**
*   **Description:** Write a procedure `product` that takes a variable number of numeric arguments and returns their product.
*   **E.g.:** `(product 2 3 4)` should return `24`.
*   **Learning Goal:** Learn the "dot" notation in `lambda` or `define` to create variadic functions.

**Exercise 19: `mix` (from PPL2021.06.22)**
*   **Description:** Define the function `mix` which takes a function as its first argument, followed by a variable number of other arguments.
*   **E.g.:** `(mix (lambda (x) (* x x)) 1 2 3)` should return `(1 (2 (3 (1 4 9) 3) 2) 1)`.
*   **Learning Goal:** Combine variadic functions, higher-order functions, and complex list-building recursion to solve a challenging exam problem.

**Exercise 20: One-Pass `fold-left-right` (from PPL2023.06.12)**
*   **Description:** Write a function that computes both `fold-left` and `fold-right` in a single pass over the list, returning the results in a pair.
*   **E.g.:** `(fold-left-right string-append "" '("a" "b" "c"))` should return the pair `("cba" . "abc")`.
*   **Learning Goal:** Learn to manage multiple accumulators in a single recursive helper function for efficiency, a more advanced but powerful technique.

---

After completing these 20 exercises, you will be well-prepared for about half of the exam problems presented. The next modules in the course would systematically introduce **State/Closures**, **Vectors**, **Continuations (`call/cc`)**, and **Macros (`define-syntax`)** to cover the remaining, more advanced problems.

### **Part 2: State, Memory, and Advanced Control (Exercises 21-40)**

This part of the course introduces concepts that break the "purely functional" mold. You will learn to manage state, work with mutable data structures like vectors, and seize control of program flow with continuations and macros.

---

#### **Module 5: State and Closures**

This module introduces `set!` and the concept of a closure maintaining its own private state. This is fundamental to creating objects, generators, and memoization caches.

**Exercise 21: A Simple Counter**
*   **Description:** Write a function `make-counter` that takes no arguments and returns a procedure. Each time the returned procedure is called, it should return a number that is one greater than the last time it was called. The first call should return 1.
*   **E.g.:** `(define c1 (make-counter))` `(c1)` → `1`, `(c1)` → `2`. `(define c2 (make-counter))` `(c2)` → `1`.
*   **Learning Goal:** Understand the core pattern of a closure: a `lambda` that captures and modifies a variable from its lexical environment using `set!`.

**Exercise 22: Bank Account Object**
*   **Description:** Write a function `make-account` that takes an initial balance. It should return a "dispatcher" procedure that accepts messages like `'balance`, `'withdraw`, and `'deposit`.
*   **E.g.:** `(define acc (make-account 100))` `(acc 'deposit 50)` `(acc 'withdraw 30)` `(acc 'balance)` → `120`.
*   **Learning Goal:** Implement the object-oriented dispatcher pattern. This is a crucial building block for the `define-dispatcher` macro seen in PPL2022.07.06.

**Exercise 23: Memoization**
*   **Description:** Write a higher-order function `memoize` that takes a procedure `proc` (of one argument) and returns a memoized version of it. The memoized version should store results in a hash table to avoid re-computation for the same input.
*   **E.g.:** `(define slow-fib ...)` `(define fast-fib (memoize slow-fib))` `(fast-fib 40)` should be much faster on the second call.
*   **Learning Goal:** Use state to implement a powerful optimization technique.

**Exercise 24: A Stateful Generator (from PPL2022.02.10)**
*   **Description:** Implement the `r` function from the exam. It should be a generator that returns numbers from a starting value `x` to an upper limit `y` with a given step `s`. When `y` is reached, it should return `y` indefinitely.
*   **E.g.:** `(define g (r 10 16 2))` `(g)` → `10`, `(g)` → `12`, `(g)` → `14`, `(g)` → `16`, `(g)` → `16`.
*   **Learning Goal:** Directly practice solving an exam problem that relies on creating a generator with internal state.

**Exercise 25: `delay` and `force` (Call-by-Need)**
*   **Description:** Implement the `delay` and `force` constructs. `(delay <expr>)` should return a "promise" without evaluating `<expr>`. `(force <promise>)` should evaluate the expression the first time it's called and cache the result for subsequent calls.
*   **Learning Goal:** Understand and implement lazy evaluation, a key computer science concept that uses closures and state. This prepares you for the `delay-master` problem in PPL2024.09.03.

---

#### **Module 6: Vectors and Matrices**

This module introduces vectors, Racket's primary mutable, fixed-length array structure. They are essential for tasks requiring random access or representing grids like matrices.

**Exercise 26: Vector Map**
*   **Description:** Write a function `vector-map` that takes a procedure and a vector, and returns a *new* vector where the procedure has been applied to each element.
*   **E.g.:** `(vector-map (lambda (x) (* x x)) '#(1 2 3))` should return `#(1 4 9)`.
*   **Learning Goal:** Learn the basic operations: `make-vector`, `vector-ref`, `vector-set!`, and `vector-length`.

**Exercise 27: `multi-list->vector` (from PPL2021.01.20)**
*   **Description:** Implement the `multi-list->vector` function. It takes a deep list and converts it into a nested data structure where each level of list is converted into a vector.
*   **E.g.:** `(multi-list->vector '(1 (2 3) 4))` should return `#(1 #(2 3) 4)`.
*   **Learning Goal:** Combine deep recursion with vector operations. This is a direct application from an exam.

**Exercise 28: `create-matrix` (from PPL2021.08.31)**
*   **Description:** Write a procedure that takes a dimension `n` and a default value, and creates an `n`-by-`n` matrix (a vector of vectors) filled with that default value.
*   **E.g.:** `(create-matrix 2 #f)` should return `#( #(#f #f) #(#f #f) )`.
*   **Learning Goal:** Practice nested iteration/recursion for creating 2D structures with vectors.

**Exercise 29: Matrix Transpose**
*   **Description:** Write a function `transpose` that takes an `n`-by-`m` matrix (vector of vectors) and returns its transpose, an `m`-by-`n` matrix.
*   **Learning Goal:** Practice complex element access (`(vector-ref (vector-ref m i) j)`) and reconstruction.

**Exercise 30: Bijection Check (Stateful Part of PPL2021.08.31)**
*   **Description:** Write a procedure `is-injective?` that takes a "function matrix" `M` (where `M[i][j]` represents `f(i, j)`). Check if the function is injective by ensuring no two distinct inputs map to the same output. Use a "seen" matrix to keep track of outputs you have already encountered.
*   **Learning Goal:** Use a matrix for stateful checking, directly addressing the core logic of the exam's bijection problem.

---

#### **Module 7: Continuations (`call/cc`)**

This module introduces `call/cc`, a powerful tool for non-local control flow. Mastering it allows you to "jump" out of deep computations, implementing things like `return` and `break`.

**Exercise 31: Find First Negative**
*   **Description:** Write a function `find-first-negative` that searches a list of numbers. It should return the first negative number it finds *immediately*, without processing the rest of the list. If no negative numbers are found, it should return `#f`.
*   **Learning Goal:** Understand the fundamental use of `call/cc` to create an "escape hatch" from a computation.

**Exercise 32: `product-with-zero`**
*   **Description:** Write a function that computes the product of a list of numbers. If it ever encounters a `0`, it should immediately return `0` without multiplying by any subsequent numbers.
*   **Learning Goal:** Reinforce the `call/cc` pattern for early exit based on a specific value.

**Exercise 33: A Loop with `break`**
*   **Description:** Write a `loop-with-break` function that takes a list and a procedure `body`. It should iterate through the list, calling `body` on each element. Inside `body`, a globally available function `break` should be able to be called to immediately exit the loop and return a value.
*   **Learning Goal:** Practice setting up a continuation that can be used by a separate, nested procedure. This is the core of the `For` loop problems.

**Exercise 34: `store-cc` and `run-cc` (from PPL2022.09.01)**
*   **Description:** Implement the `store-cc` and `run-cc` constructs from the exam. `store-cc` should capture its continuation and push it onto a global stack. `run-cc` should pop the most recent continuation and invoke it.
*   **Learning Goal:** Manage a collection of continuations, a more advanced application of `call/cc`.

**Exercise 35: `for-each/cc` (from PPL2023.01.25)**
*   **Description:** Implement the `for-each/cc` procedure. It takes a predicate, a list, and a body. When the predicate is true for an element, the continuation of the `body` is stored in a global *queue*. A separate `use-cc` procedure should invoke the oldest continuation from the queue.
*   **Learning Goal:** Work with a queue of continuations instead of a stack, and understand how continuations capture the *rest of the computation*.

---

#### **Module 8: Macros (`define-syntax`)**

This module teaches you how to extend Racket's syntax itself. Macros operate on code as data, allowing you to create new control structures that are impossible to write as functions.

**Exercise 36: A Simple `when-not` Macro**
*   **Description:** Write a macro `when-not` that is the opposite of `when`. `(when-not <condition> <body> ...)` should execute the body only if the condition is false.
*   **E.g.:** `(when-not (= 2 2) (displayln "hello"))` should do nothing.
*   **Learning Goal:** Understand the basic structure of `define-syntax` and `syntax-rules`.

**Exercise 37: A `swap!` Macro**
*   **Description:** Write a macro `swap!` that takes two variable names and swaps their values.
*   **E.g.:** `(define a 5) (define b 10) (swap! a b)` should result in `a` being `10` and `b` being `5`.
*   **Learning Goal:** Illustrate how macros can achieve effects that functions cannot (like re-assigning free variables).

**Exercise 38: Implement `nlet` (from PPL2025.02.06)**
*   **Description:** Implement the "named let" construct as a macro `nlet`. `(nlet name ((var val) ...) body ...)` should be transformed into `(let name ((var val) ...) body ...)` which in turn expands to a local recursive function.
*   **Learning Goal:** Practice a direct, common macro transformation pattern found in an exam.

**Exercise 39: Implement `let-cond` (from PPL2024.06.06)**
*   **Description:** Implement the `let-cond` macro. It should test conditions in order. For the first one that is true, it should create the associated bindings and execute the corresponding "then-part". If all are false, it executes an else-part.
*   **Learning Goal:** Write a more complex macro that transforms a custom structure into a standard `cond` expression.

**Exercise 40: Basic `For` Loop Macro**
*   **Description:** Implement the iteration part of the `For` loop from PPL2023.02.15. Your macro `(For i from start to end do body ...)` should expand into a recursive loop (e.g., using a named `let`). This version does not need to handle `break`.
*   **Learning Goal:** Master the fundamental macro pattern of converting a user-friendly loop syntax into the underlying recursive reality of Scheme. This provides the scaffold for adding `break` later using continuations.

### **Part 3: Advanced Patterns and Concept Fusion (Exercises 41-60)**

Now that you have the foundational tools, this part of the course will challenge you to use them with greater sophistication. We will focus on efficient recursion, modeling complex data structures from other paradigms (a very common exam theme), writing more powerful macros, and solving problems that require fusing state, continuations, and macros together.

---

#### **Module 9: Efficient Recursion and Tail Calls**

While standard recursion is powerful, professional Scheme code uses tail recursion to avoid stack overflow on large inputs. This module focuses on mastering this optimization.

**Exercise 41: Tail-Recursive Factorial**
*   **Description:** Rewrite the classic factorial function to be tail-recursive. This requires a helper function that uses an accumulator to pass the intermediate result forward.
*   **E.g.:** `(tr-factorial 5)` should return `120` without growing the stack for each recursive call.
*   **Learning Goal:** Master the fundamental accumulator pattern for converting a simple recursion into a tail-recursive one.

**Exercise 42: Implement `my-foldl` (Fold Left)**
*   **Description:** Implement the `foldl` (or `fold-left`) function. Unlike `foldr`, `foldl` processes elements from left to right and is naturally tail-recursive.
*   **E.g.:** `(my-foldl (lambda (acc x) (cons x acc)) '() '(1 2 3))` should return `(3 2 1)`.
*   **Learning Goal:** Understand the difference between `foldl` and `foldr` and see how `foldl`'s structure is inherently iterative and efficient.

**Exercise 43: Palindrome Check**
*   **Description:** Write a tail-recursive function `is-palindrome?` that checks if a list is the same forwards and backwards.
*   **E.g.:** `(is-palindrome? '(r a c e c a r))` should return `#t`.
*   **Learning Goal:** Apply tail recursion to a problem that isn't a simple accumulation, possibly by comparing the list to its reverse or using a more complex two-pointer recursive approach.

**Exercise 44: Range Generator**
*   **Description:** Write a tail-recursive function `range` that takes a `start` and `end` integer and returns a list of numbers from `start` up to (but not including) `end`.
*   **E.g.:** `(range 3 7)` should return `(3 4 5 6)`.
*   **Learning Goal:** Practice building a list in reverse using an accumulator and then reversing it once at the end for the correct order, a common tail-recursive list-building pattern.

**Exercise 45: Deep List Equality**
*   **Description:** Write a function `deep-equal?` that takes two deep lists and returns `#t` if they have the same structure and the same atomic values, and `#f` otherwise.
*   **E.g.:** `(deep-equal? '(1 (2)) '(1 (2)))` → `#t`. `(deep-equal? '(1 (2)) '(1 2))` → `#f`.
*   **Learning Goal:** Handle complex, multi-branching recursion cleanly. While making this fully tail-recursive is very advanced (requires trampolining), focus first on a correct and clean standard recursion.

---

#### **Module 10: Algebraic Data Types in Scheme**

A very common exam theme is to provide a data structure definition from a typed language (like Haskell) and ask you to implement it and its operations in Scheme. This module gives you a systematic way to do this using "tagged lists."

**Exercise 46: Constructors and Predicates for Binary Trees**
*   **Description:** Let's model a binary tree where `(Leaf 5)` is `' (Leaf 5)` and `(Node (Leaf 1) (Leaf 2))` is `'(Node (Leaf 1) (Leaf 2))`. Write the constructor functions `make-leaf`, `make-node` and the predicate functions `leaf?` and `node?`.
*   **Learning Goal:** Establish the core pattern for representing an Algebraic Data Type (ADT) in Scheme.

**Exercise 47: `map-tree`**
*   **Description:** Using the tree structure from the previous exercise, write a `map-tree` function that takes a procedure and a tree, and applies the procedure to every value in the leaves, returning a new tree with the same structure.
*   **Learning Goal:** Apply the recursive processing pattern to your custom ADT.

**Exercise 48: `fold-tree`**
*   **Description:** Write a `fold-tree` function. It should take two procedures (one for handling leaves, one for combining results from nodes) and a tree, and reduce the tree to a single value.
*   **Learning Goal:** Implement the catamorphism for a tree structure, the most powerful way to process it.

**Exercise 49: `fmap` for the `Expr` ADT (from PPL2024.02.02)**
*   **Description:** Model the `Expr` data type: `data Expr a = Var a | Val Int | Op (Expr a) (Expr a)`. Write constructors `make-var`, `make-val`, `make-op` and a `fmap` function that applies a procedure only to the `Var` constructors.
*   **E.g.:** `(fmap (lambda (x) (string-append x "!")) '(Op (Var "a") (Val 5)))` should return `'(Op (Var "a!") (Val 5))`.
*   **Learning Goal:** Directly practice a key part of an exam question, focusing on functorial application over a custom ADT.

**Exercise 50: `>>=` for the `Expr` ADT (from PPL2024.02.02)**
*   **Description:** For the same `Expr` ADT, implement the monadic bind operator `>>=`. The `>>=` function takes an `Expr` and a procedure `f`. It applies `f` to the value inside a `Var`, and `f` is expected to return a new `Expr`. It should recursively apply itself to `Op`s and do nothing to `Val`s.
*   **Learning Goal:** Tackle the most difficult part of the exam problem, requiring a deep understanding of how Monads transform structures.

---

#### **Module 11: Advanced Macros**

This module focuses on writing macros that are recursive or manage complex syntactic transformations, targeting the most difficult macro-based exam questions.

**Exercise 51: `let**` (from PPL2023.07.03)**
*   **Description:** Implement the `let**` macro. It behaves like `let*`, but if a variable is given without a value, it inherits the value of the most recently defined variable. A `def:` keyword provides a default for the very first variable.
*   **Learning Goal:** Write a recursive macro that peels off one binding at a time and passes the "state" (the last value) into the expansion of the rest of the macro.

**Exercise 52: `block-then` (from PPL2022.01.21)**
*   **Description:** Implement the `block-then` macro. `(block <expr1> ... then <expr2> ... where (v <- a b) ...)` should expand to create two lexical scopes. The first bindings `a` are for `<expr1>`, and the second bindings `b` are for `<expr2>`.
*   **Learning Goal:** Practice writing a macro that manages multiple, distinct code blocks and binding scopes.

**Exercise 53: An `unless` Macro**
*   **Description:** Write a macro `unless` that is the inverse of `if`. `(unless <condition> <then-expr> <else-expr>)` should execute `<then-expr>` if the condition is false, and `<else-expr>` if it is true.
*   **Learning Goal:** A straightforward but essential exercise to solidify your understanding of how macros re-arrange syntax into existing forms (`if`).

**Exercise 54: A `while` Loop Macro**
*   **Description:** Implement a traditional `while` loop as a macro. `(while <condition> <body> ...)` should execute the body as long as the condition remains true.
*   **Learning Goal:** Practice creating a common imperative construct by expanding it into a recursive function (using a named `let`).

**Exercise 55: `define-dispatcher` (from PPL2022.07.06)**
*   **Description:** Implement the `define-dispatcher` macro. This macro should automatically generate the dispatcher `lambda` for an object, taking a list of method names and an optional parent object.
*   **Learning Goal:** This is a "macro-generating" macro. It requires manipulating lists of symbols within the macro to generate a complex `case` statement, representing the peak of macro difficulty seen in the exams.

---

#### **Module 12: Fusing Concepts - Capstone Problems**

This final module contains problems that require you to combine multiple advanced topics (state, continuations, ADTs, macros) to arrive at a solution.

**Exercise 56: `For` Loop with `continue` (from PPL2024.01.11)**
*   **Description:** Extend the `For` loop macro from Exercise 40 to support both `break` and `continue`.
*   **Learning Goal:** This is the ultimate continuation challenge. It requires using *two* nested `call/cc` calls: an outer one for `break` (exiting the whole loop) and an inner one for `continue` (skipping to the next iteration).

**Exercise 57: `delay-master` and `linked-delay` (from PPL2024.09.03)**
*   **Description:** Implement the "master promise" construct. `(delay-master <expr>)` creates a master promise. `(linked-delay <master> <expr>)` creates a linked promise. When the master is forced, it evaluates itself and then forces all of its linked promises.
*   **Learning Goal:** Fuse the `delay/force` pattern with advanced state management. The master promise object must now contain a list of its children.

**Exercise 58: Coroutines with Continuations**
*   **Description:** Write a `make-coroutine` function that takes a procedure (the coroutine body). The body can call a `(yield)` function to pass control back to the caller. When the coroutine is called again, it resumes from where it left off.
*   **Learning Goal:** A deep exploration of `call/cc`. This requires swapping continuations to pass control back and forth, a powerful technique for cooperative multitasking.

**Exercise 59: `contains-length?` (from PPL2025.07.03)**
*   **Description:** Write a function that takes a deep list and checks if every list and sub-list (at every level) contains its own length as an element.
*   **Learning Goal:** A tricky recursive problem that combines structural validation with element validation. It serves as a great review of deep recursion, predicates, and higher-order functions like `andmap` or a custom `all?`.

**Exercise 60: Transactional Bank Account**
*   **Description:** Extend the `make-account` object from Exercise 22. Add a `(acc 'transaction <proc>)` method. The procedure `<proc>` will be executed with a special `abort` function. If `abort` is ever called, all state changes made during the transaction are rolled back.
*   **Learning Goal:** Fuse state management (objects) with continuations. The `transaction` method will use `call/cc` to save the state (the continuation). If `abort` is called, it simply invokes that continuation to discard the recent changes.

### **Part 4: Elegance, Performance, and Advanced Synthesis (Exercises 61-80)**

In this section, you'll move beyond just finding a working solution. You will learn to write more idiomatic, efficient, and elegant Scheme code. The exercises will challenge you to see problems from multiple perspectives and choose the best tools for the job, culminating in complex problems that mirror the hardest exam questions.

---

<h4>Module 13: Advanced List and Sequence Manipulation</h4>

This module focuses on sophisticated sequence operations, often requiring clever use of multiple pointers, recursion on multiple lists simultaneously, and generating infinite data structures.

**Exercise 61: Interleave Two Lists**
*   **Description:** Write a function `interleave` that takes two lists and returns a new list containing elements from each, alternating. If one list is longer, its remaining elements should be appended at the end.
*   **E.g.:** `(interleave '(a b c) '(1 2 3 4 5))` should return `'(a 1 b 2 c 3 4 5)`.
*   **Learning Goal:** Practice recursion over multiple lists at once.

**Exercise 62: `zip`**
*   **Description:** Implement the `zip` function. It takes two lists and returns a list of pairs, where the i-th pair contains the i-th element from each list. The output list's length is determined by the shorter of the two input lists.
*   **E.g.:** `(zip '(a b c) '(1 2))` should return `'((a 1) (b 2))`.
*   **Learning Goal:** A classic multi-list recursion that is fundamental for many other operations.

**Exercise 63: Group Consecutive Elements**
*   **Description:** Write a function `group-consecutive` that takes a list and groups identical consecutive elements into sub-lists.
*   **E.g.:** `(group-consecutive '(1 1 2 3 3 3 1 1))` should return `'((1 1) (2) (3 3 3) (1 1))`.
*   **Learning Goal:** A more complex recursive pattern that requires "looking ahead" or passing state about the previous element.

**Exercise 64: Infinite Streams**
*   **Description:** A stream can be represented as a pair of `(head . (lambda () tail))`. Implement a stream of all natural numbers `nats`. Also write `stream-take n s` which returns a list of the first `n` elements of stream `s`, and `stream-map f s` which applies a function to every element of a stream.
*   **Learning Goal:** Master the core concept of lazy infinite data structures using `lambda` to delay computation, a powerful alternative to `delay`/`force`.

**Exercise 65: The Sieve of Eratosthenes (Stream-based)**
*   **Description:** Using the stream framework from the previous exercise, implement the Sieve of Eratosthenes to generate an infinite stream of prime numbers. Start with the stream of naturals from 2. The head is a prime. The tail is recursively filtered by removing all multiples of the head.
*   **Learning Goal:** A beautiful and classic algorithm that perfectly demonstrates the power of lazy evaluation and stream processing.

---

<h4>Module 14: Simulating Paradigms and Interpreters</h4>

This module challenges you to use Scheme's flexibility to simulate features from other languages or even to write small interpreters, a common theme in advanced programming language courses.

**Exercise 66: Representing Haskell's `Maybe`**
*   **Description:** Model Haskell's `Maybe a = Just a | Nothing`. Write constructors `just` and `nothing`, and implement `fmap` and `>>=` for this data type. In Scheme, `nothing` can be represented as a unique value or symbol.
*   **Learning Goal:** Practice modeling ADTs and implementing Functor and Monad instances for them, a skill directly tested in the exams.

**Exercise 67: A Simple Expression Evaluator**
*   **Description:** Write a function `eval` that evaluates a simple arithmetic expression represented as a list. The expression can contain numbers and the symbols `+` and `*`.
*   **E.g.:** `(eval '(+ 3 (* 2 5)))` should return `13`.
*   **Learning Goal:** Write a basic interpreter, which is the heart of what many exam problems are asking you to do (evaluate a custom data structure).

**Exercise 68: Evaluator with an Environment**
*   **Description:** Extend the previous evaluator to support variables. The `eval` function should now take an expression and an environment (e.g., a list of `(var . val)` pairs). Add a `let` construct to the expression language.
*   **E.g.:** `(eval '(let ((x 5)) (+ x 3)) '())` should return `8`.
*   **Learning Goal:** Understand how environments are passed through a recursive evaluation to manage variable scope, a core concept of language implementation.

**Exercise 69: Simulating Prolog-style Unification**
*   **Description:** Write a simple `unify` function. It takes two terms (which can be variables represented as symbols starting with `?`, or constants) and a substitution (an environment). It returns a new substitution if they can be unified, or `#f` if not.
*   **E.g.:** `(unify '?x 5 '())` should return `'((?x . 5))`. `(unify '(?x . ?y) '(5 . 6) '())` should return `'((?y . 6) (?x . 5))`.
*   **Learning Goal:** A challenging but rewarding exercise in symbolic manipulation and recursive data structure matching.

**Exercise 70: A Finite State Automaton Simulator**
*   **Description:** Write a function `sim-fsa` that takes an FSA description (states, alphabet, transition function, start state, final states) and an input string (list of characters). It should return `#t` if the FSA accepts the string, `#f` otherwise.
*   **Learning Goal:** Model a computational process. This is the sequential precursor to the concurrent Erlang FSA problems and tests your ability to manage state transitions.

---

<h4>Module 15: Advanced Macro Patterns and Hygiene</h4>

This module dives deeper into macro creation, exploring how to generate unique identifiers to avoid accidental variable capture (hygiene) and how to write more readable, powerful macros.

**Exercise 71: An `aif` (Anaphoric If) Macro**
*   **Description:** Implement an anaphoric `if`. `(aif <condition> <then-expr> <else-expr>)` should be like `if`, but if `<condition>` evaluates to a true value, that value is bound to the special variable `it` within the `<then-expr>`.
*   **E.g.:** `(aif (member 'b '(a b c)) (cons 'found it))` should return `'(found b c)`.
*   **Learning Goal:** Learn to use `let` within a macro expansion to create local bindings.

**Exercise 72: A `let-when` Macro**
*   **Description:** Write a `let-when` macro that combines `let` and `when`. `(let-when ((var val) ...) <condition> <body> ...)` should create the bindings and only execute the body if the condition is true.
*   **Learning Goal:** Practice combining multiple forms (`let`, `when`) in a single macro for conciseness.

**Exercise 73: A `for` Loop with `#:break-if`**
*   **Description:** Write a `for` loop macro that iterates through a sequence. It should support a keyword argument for early exit.
*   **E.g.:** `(for ((i '(1 2 -5 4))) #:break-if (negative? i) (displayln i))` should print `1` and `2`, then exit.
*   **Learning Goal:** Practice parsing keyword arguments within a macro, a more advanced syntactic pattern.

**Exercise 74: A Hygienic `while` Macro**
*   **Description:** Re-implement the `while` loop from Exercise 54. This time, ensure that any internal variables you use in the expansion (e.g., the name of the recursive function) are hygienic, meaning they won't clash with user variables. Use `(generate-temporaries ...)` for this.
*   **Learning Goal:** Understand the concept of macro hygiene and how to explicitly manage it when `syntax-rules` isn't enough.

**Exercise 75: A Simple `class` Macro**
*   **Description:** Write a `class` macro that simplifies the object-oriented pattern from Module 5. `(class <name> ((field val) ...) (method (args) body) ...)` should expand into a constructor function `(make-<name> ...)` and a dispatcher.
*   **Learning Goal:** An ambitious macro that synthesizes state, closures, and complex syntactic transformation into a single, high-level construct.

---

<h4>Module 16: Mashup and Synthesis Capstone Problems</h4>

This final module contains problems inspired by multiple exam questions, requiring you to combine ideas from different domains into a single, cohesive solution.

**Exercise 76: Continuable `fold`**
*   **Description:** Write a function `continuable-fold` that takes a procedure, a base, and a list. The procedure it takes receives three arguments: the current element, the accumulated value, and a `break` continuation. If `break` is called with a value, the fold stops immediately and returns that value.
*   **Learning Goal:** Fuse higher-order functions (`fold`) with continuations (`call/cc`).

**Exercise 77: Stateful Tree Traversal**
*   **Description:** Create a tree "walker" object. `(make-walker <tree>)` should return a dispatcher. `(walker 'next)` should return the next element in a depth-first traversal. `(walker 'reset)` should restart the traversal. The walker must not destroy or copy the original tree.
*   **E.g.:** `(define w (make-walker '(1 (2) (3))))` `(w 'next)` → `1`, `(w 'next)` → `2`, `(w 'next)` → `3`.
*   **Learning Goal:** A difficult problem combining ADTs, state management, and potentially continuations to manage the traversal state without a simple list.

**Exercise 78: Macro-Generated `let-cond+` (from PPL2024.07.03)**
*   **Description:** Implement the `let-cond+` macro. It works like `let-cond`, but it executes the `then-part` for *all* conditions that are true, in sequence. The final result is the value of the last `then-part` executed.
*   **Learning Goal:** A subtle variation on a previous problem that tests your attention to detail in macro expansion and state flow (managing the "result" variable).

**Exercise 79: A Vector-Based Matrix with Method-like Access**
*   **Description:** Create a `make-matrix` function that returns a procedure. This procedure acts as an object for a matrix implemented with a single, flat vector (`#(c11 c12 c21 c22)`). It should respond to messages like `'(ref row col)` and `'(set! row col val)`.
*   **Learning Goal:** Combine vector arithmetic (calculating index as `row * cols + col`) with the dispatcher/object pattern.

**Exercise 80: The Ultimate Challenge: A Macro for a Simple `async/await`**
*   **Description:** (Ambitious) Write `async` and `await` macros. `(async <expr>)` should start running `<expr>` and return a promise immediately. `(await <promise>)` should pause the current function's execution (using continuations) until the promise has a value, then resume. This requires a global task scheduler (a list of pending continuations).
*   **Learning Goal:** This is a capstone problem that requires fusing almost every advanced concept: macros for syntax, continuations for control flow, and state management for the task queue and promise values. Solving this demonstrates true mastery of the language's advanced features.

### **Part 5: Mastery, Synthesis, and Design (Exercises 81-100)**

This final part of the course moves beyond implementing given specifications. You will be asked to design data structures, create mini-languages, simulate complex computational models, and combine state, control, and metaprogramming to solve capstone problems. Successfully completing this section signifies a deep and flexible understanding of the language.

---

<h4>Module 17: Metaprogramming and Language Design</h4>

This module focuses on using Racket to build abstractions so powerful they feel like new language features. You will be designing and implementing your own data structures and control flow mechanisms from scratch.

**Exercise 81: File System ADT**
*   **Description:** Design and implement a data structure for a simple file system tree. A `Directory` should have a name and a list of contents (other directories or files). A `File` should have a name and content (e.g., a string). Write constructors and a `find-file` function that takes a path (e.g., `'(/ "docs" "report.txt")`) and returns the file's content or `#f`.
*   **Learning Goal:** Design a non-trivial, nested ADT and write a complex recursive search function for it.

**Exercise 82: A `match` Macro**
*   **Description:** Implement a `match` macro that works on your custom ADTs (and lists). It should take a value and a series of clauses. Each clause has a pattern and a body. The macro should expand to code that finds the first matching pattern, binds variables from the pattern, and executes the body.
*   **E.g.:** `(match my-tree ((Leaf v) (displayln v)) ((Node l r) (do-something-with l r)))`.
*   **Learning Goal:** The pinnacle of ADT processing. This requires writing a macro that de-structures data, a core feature of languages like Haskell and Rust.

**Exercise 83: An ADT Definition Macro**
*   **Description:** Write a macro `define-adt` that automatically generates constructors, predicates, and selectors for a tagged-list ADT.
*   **E.g.:** `(define-adt Point (x y))` should automatically define `make-point`, `point?`, `point-x`, and `point-y`.
*   **Learning Goal:** Practice metaprogramming at a higher level, writing macros that write code for you, reducing boilerplate and errors.

**Exercise 84: `define-dispatcher` with Inheritance**
*   **Description:** Extend the `define-dispatcher` macro (from PPL2022.07.06 and Exercise 55) to support single inheritance. If a message is not understood by the child object, it should be delegated to the parent object.
*   **Learning Goal:** Evolve a complex macro to handle delegation, forcing you to manage the flow of control and arguments between different object contexts.

**Exercise 85: A Path-Finding DSL**
*   **Description:** Write an interpreter for a simple path-finding Domain-Specific Language. An expression like `'((start 0 0) (move right 3) (move down 2))` should be evaluated by a function `(run-path <expr>)` to return the final coordinates, e.g., `'(3 . 2)`.
*   **Learning Goal:** Design and implement a small, specialized language, which involves parsing, maintaining state (the current position), and evaluation.

---

<h4>Module 18: Advanced Control Flow & Concurrency Simulation</h4>

This module pushes the boundaries of control flow, using continuations to implement features normally found in operating systems or concurrent languages.

**Exercise 86: Simulating an Erlang-style Agent**
*   **Description:** Write a function `spawn-agent` that takes an initial state and a `receive-loop` procedure. It should return a "PID" (which can just be the agent's message-handling procedure). Write a corresponding `send` function `(send pid msg)`. The agent should process messages from its "mailbox" (a list) one at a time, updating its state.
*   **Learning Goal:** Model the fundamental actor model of concurrency, managing state and a message queue in a single-threaded environment.

**Exercise 87: Agent with Error Handling (`try/catch`)**
*   **Description:** Implement a `try/catch` macro. `(try <body> (catch (ex) <handler>))` should execute `<body>`. If `(throw ex)` is called within the body, control should immediately jump to the handler. This can be implemented with `call/cc` to create an "error continuation."
*   **Learning Goal:** Use continuations to implement a robust error-handling mechanism, a key feature of modern languages.

**Exercise 88: A Generator with `yield`**
*   **Description:** Using `call/cc`, write a `make-generator` function. It takes a procedure `g` that can call a `yield` function to return a value. When the generator is invoked again, it resumes execution immediately after the `yield`.
*   **Learning Goal:** Master the concept of swapping continuations to create coroutines, a powerful control structure for cooperative multitasking.

**Exercise 89: Backtracking for a Sudoku Solver**
*   **Description:** Write a simple Sudoku solver. Use continuations to handle backtracking. When you make a choice for a cell, save the continuation `(call/cc (lambda (k) ...))`. If you reach a dead end (a cell with no valid numbers), invoke the saved continuation to jump back to the last choice point and try the next number.
*   **Learning Goal:** A very practical and powerful application of continuations for search problems, avoiding the complexity of managing an explicit state stack.

**Exercise 90: Simulating `async/await` with a Scheduler**
*   **Description:** This is a major challenge. Implement `async`, `await`, and a `run-event-loop!` function. `(async <expr>)` returns a promise. `(await <promise>)` pauses the current task (saving its continuation) if the promise is not ready. `run-event-loop!` runs tasks from a queue until all are complete.
*   **Learning Goal:** A capstone control-flow problem that simulates a core feature of modern asynchronous programming, requiring a deep understanding of state, callbacks, and continuations.

---

<h4>Module 19: Performance, Optimization, and Idiomatic Code</h4>

This final set of "pure" programming exercises focuses on writing code that is not just correct, but also efficient and elegant, using the full power of the language's idioms.

**Exercise 91: Continuation-Passing Style (CPS) `map-tree`**
*   **Description:** Convert a standard `map-tree` function to be fully tail-recursive by rewriting it in Continuation-Passing Style. The function should take an extra argument: a continuation `k` (a procedure) to which it passes its result instead of returning it directly.
*   **Learning Goal:** Understand and apply CPS transformation, a fundamental technique in compiler design and advanced functional programming for achieving tail-call optimization in all cases.

**Exercise 92: A One-Pass List Analysis**
*   **Description:** Write a *single-pass*, *tail-recursive* function `analyze-list` that takes a list of numbers and returns a list containing: the sum, the product, the maximum element, and the minimum element.
*   **Learning Goal:** An exercise in extreme efficiency, forcing you to manage multiple accumulators in a single tail-recursive loop.

**Exercise 93: Memoizing a Path-Counting Function**
*   **Description:** On a grid, you can only move right or down. Write a function `count-paths(m, n)` that counts the number of paths from the top-left corner to the bottom-right corner of an m-by-n grid. Then, write a memoized version of this function to handle large grids efficiently.
*   **Learning Goal:** Apply memoization to a function with multiple arguments and a recursive structure that involves many overlapping subproblems.

**Exercise 94: A List Zipper**
*   **Description:** Implement a list "zipper". `(make-zipper lst)` should return a representation of the list with a "cursor" at the beginning. It should support operations like `(zipper-forward z)`, `(zipper-backward z)`, `(zipper-get z)`, and `(zipper-set z val)` which performs a non-destructive update. The zipper is typically represented as two lists: elements before the cursor (reversed) and elements after the cursor.
*   **Learning Goal:** Implement a powerful functional data structure that allows for efficient, localized updates without copying the entire structure.

**Exercise 95: Generic `fold` for any ADT**
*   **Description:** Write a macro or procedure `define-fold` that takes an ADT definition (like in Exercise 83) and automatically generates a `fold` function for it. The fold would take a procedure for each constructor in the ADT.
*   **Learning Goal:** A highly abstract problem that combines metaprogramming with the core functional pattern of the catamorphism.

---

<h4>Module 20: Grand Synthesis - Final Capstone Projects</h4>

These are final, open-ended problems that require you to bring together everything you've learned to create a small but complete system.

**Exercise 96: A Complete `For` Macro**
*   **Description:** Synthesize your work from previous exercises to create a final, robust `For` macro. It should support `(For i from start to end do ...)` and include fully functional `#:break` and `#:continue` keyword clauses, implemented hygienically using continuations.
*   **Learning Goal:** Integrate advanced macros with advanced control flow (`call/cc`) to create a polished, feature-complete new language construct.

**Exercise 97: A Transactional, Memoized Cache Object**
*   **Description:** Create a caching object. It must have methods for `get`, `set`, and `transaction`. `get` should be memoized. `transaction` takes a procedure; if that procedure calls a provided `abort` function, all `set` operations performed within the transaction must be rolled back.
*   **Learning Goal:** A fusion of state management, memoization, and continuations for transactional control.

**Exercise 98: A "Proxy" System (from PPL2021.01.20)**
*   **Description:** Implement a system that simulates the Erlang proxy problem. Create a central "registry" agent. Other "client" agents can register themselves with a symbolic `Name`. A client can then send a message to another client via the registry by using its `Name` instead of its "PID," and the registry will forward the message.
*   **Learning Goal:** Model a core concurrency pattern (service discovery/indirection) using stateful agents and message-passing simulation.

**Exercise 99: A Reversible Computation**
*   **Description:** Write a function that takes a starting value and a list of procedures `(f1 f2 f3 ...)`. It should return an object that responds to `forward` and `backward`. `forward` applies the next function in the list. `backward` undoes the last function application. This is only possible for invertible functions (e.g., `+1` and `-1`), but your goal is to manage the state and the history.
*   **Learning Goal:** An exercise in managing a "history" of states and functions, pushing your object-oriented design and state management skills.

**Exercise 100: The Final Challenge: A Scheme Interpreter in Scheme (Self-Interpreter)**
*   **Description:** Write a function `my-eval` that takes a quoted Scheme expression and evaluates it. Your interpreter only needs to support a subset of the language: numbers, symbols (variable lookup), `quote`, `if`, `lambda`, and function application. You will also need to implement `my-apply` and manage an environment.
*   **Learning Goal:** This is the quintessential exercise in understanding a programming language. By implementing `eval` and `apply`, you are re-creating the heart of the language itself, demonstrating a complete and total mastery of its fundamental principles of evaluation, scope, and closures.
