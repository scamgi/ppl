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