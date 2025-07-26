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