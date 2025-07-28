Of course! It's an excellent idea to practice by creating a structured set of exercises based on past exams. The Haskell questions in your "Principles of Programming Languages" course consistently test a core set of concepts: custom data type definition, and the implementation of standard typeclasses like `Functor`, `Foldable`, `Applicative`, and occasionally `Monad`.

The exercises will be structured to build your skills progressively. We will start with the fundamentals of data structures and then move on to implementing the typeclasses one by one.

Here are the first 20 exercises of your 100-exercise course to master Haskell for your exam.

---

### **Part 1: Foundations of Data Structures**

Before you can work with typeclasses, you need to be very comfortable with defining your own data types. These initial exercises focus on that foundational skill.

**Exercise 1: A Basic Enumeration**
Define a data type `TrafficLight` that can have one of three values: `Red`, `Amber`, or `Green`.

**Exercise 2: Data Types with Fields**
Define a data type `Book` which has a `String` field for the title and an `Int` field for the year of publication. Use the record syntax for this.

**Exercise 3: A Sum Type with Data**
Define a data type `Shape` which can be either a `Circle` with a `Float` radius or a `Rectangle` with two `Float` fields for width and height.

**Exercise 4: Your First Recursive Data Type**
Define a data type for a singly-linked list of integers, `IntList`. It should either be `Empty` or a `Node` that contains an `Int` and another `IntList`.

**Exercise 5: A Generic Linked List**
Generalize the `IntList` from the previous exercise into a polymorphic `LinkedList a` that can hold values of any type `a`.

**Exercise 6: A Simple Binary Tree**
Define a data type `BinaryTree a` that can store values of any type `a`. A tree can be either a `Leaf` holding a value or a `Branch` holding a value and two sub-trees (`BinaryTree a`).

**Exercise 7: A Tree with a Variable Number of Children (from 2022.02.10)**
Define a data structure `Gtree a` for a general tree. Each node should contain some data of type `a` and a list of children, where each child is also a `Gtree a`.

**Exercise 8: A "Double Content" List (from 2024.09.03)**
Define a data structure `Llist b a` that represents a list where each node contains two values: one of type `a` and one of type `b`.

**Exercise 9: A List That Knows Its Length (from 2021.08.31)**
Define a data structure `Slist a` that stores both a list of `[a]` and an `Int` representing its length. Write a smart constructor `makeSlist :: [a] -> Slist a` that automatically calculates the length.

**Exercise 10: Describing a Complex Data Type (from 2025.01.20)**
Consider the following data definition:
`data T a = A | B (T a) a | C a a`
In your own words, describe what this data structure represents. How would you construct a value of type `T Int` that uses all three constructors?

---

### **Part 2: Making Your Types Usable (`Show` and `Eq`)**

In the exams, you are often asked to derive `Show` and `Eq`. These exercises will help you understand how to implement them manually for more control.

**Exercise 11: Custom `Show` for a `Book`**
Make the `Book` type from Exercise 2 an instance of `Show`. For a book with title "Moby Dick" and publication year 1851, the output of `show` should be `"Moby Dick (1851)"`.

**Exercise 12: Comparing `Shape`s**
Make the `Shape` type from Exercise 3 an instance of `Eq`. Two shapes are equal if they are the same type of shape and have the same dimensions.

**Exercise 13: Showing a `LinkedList`**
Make the `LinkedList a` from Exercise 5 an instance of `Show` (with the appropriate type constraint on `a`). A list containing 1, 2, 3 should be displayed as `1 -> 2 -> 3 -> Empty`.

**Exercise 14: The Problem of Recursive `Show` (from 2025.02.06)**
The `Clist` (circular list) from the exam cannot simply derive `Show`. In a comment, explain why this would lead to an infinite loop.

**Exercise 15: Showing a `Gtree`**
Make the `Gtree a` from Exercise 7 an instance of `Show`. Try to format it in a way that is readable, for example, by indenting children.

---

### **Part 3: The `Functor` Typeclass**

This is one of the most frequently tested concepts. A `Functor` is any data structure that you can `map` over.

**Exercise 16: A `Functor` for `LinkedList`**
Make the `LinkedList a` from Exercise 5 an instance of `Functor` by implementing `fmap`.

**Exercise 17: A `Functor` for `BinaryTree`**
Make the `BinaryTree a` from Exercise 6 an instance of `Functor`.

**Exercise 18: The `Fpair` Functor (from 2022.06.16)**
Consider the data type `Fpair s a`, which can be `Fpair a a s` or `Pair a a`. Make it an instance of `Functor` with respect to the type `a`.

**Exercise 19: The `Expr` Functor (from 2024.01.11 & 2024.02.02)**
Given the following data type for an expression:
`data Expr a = Var a | Const Int | Op (Expr a) (Expr a)`
Make it an instance of `Functor`. The function should only be applied to the `Var` constructors.

**Exercise 20: A Two-Parameter Functor**
Consider the following data type:
`data Result e v = Error e | Success v`
This is a common way to handle operations that can fail. Make `Result e v` an instance of `Functor`. Which type variable should `fmap` apply to? Why?

Of course! Let's continue building your Haskell skills.

The next set of exercises will focus on the `Foldable` and `Applicative` typeclasses. `Foldable` is about consuming a data structure to produce a summary value (like finding the sum or length). `Applicative` is a powerful way to apply functions that are themselves wrapped in a structure. Mastering these is crucial, as they appear in almost every exam.

---

### **Part 4: The `Foldable` Typeclass**

A `Foldable` structure is one that can be "folded" or "reduced" into a single value. The most important function to implement is `foldr`.

**Exercise 21: A `Foldable` `LinkedList`**
Make the `LinkedList a` from Exercise 5 an instance of `Foldable` by implementing `foldr`.

**Exercise 22: A `Foldable` `BinaryTree`**
Make the `BinaryTree a` from Exercise 6 an instance of `Foldable`. The fold should process the left subtree, then the root, then the right subtree (an in-order traversal).

**Exercise 23: `Foldable` for a General Tree (from 2022.02.10)**
Make the `Gtree a` from Exercise 7 an instance of `Foldable`. You will likely need to use `foldr` on the list of children. A helper function like `gtree2list` might be useful.
*Hint: The fold of a node `Gtree x xs` should combine `x` with the folds of all trees in the list `xs`.*

**Exercise 24: A `Foldable` Binary/Ternary Tree (from 2021.06.22)**
Consider the following data type:
`data BTT a = Nil | B a (BTT a) (BTT a) | T a (BTT a) (BTT a) (BTT a)`
Make `BTT a` an instance of `Foldable`. You must handle all three constructors.

**Exercise 25: A `Foldable` "Fancy Pair" (from 2022.06.16)**
Make the `Fpair s a` from Exercise 18 an instance of `Foldable`. The implementation should fold over the two values of type `a`.

**Exercise 26: A `Foldable` "Double Content" List (from 2024.09.03)**
Make the `Llist b a` from Exercise 8 an instance of `Foldable`. Remember that the instance is for `Foldable (Llist b)`, so you only fold over the values of type `a`.

**Exercise 27: A `Foldable` Deque (from 2022.07.06)**
Consider a `Deque a` implemented with two lists:
`data Deque a = Deque [a] [a]`
where the first list is the front and the second is the *reversed* back. Make this an instance of `Foldable`. A helper function `toList :: Deque a -> [a]` would make this much easier.

**Exercise 28: A `Foldable` Tree with Node Counts (from 2022.09.01)**
Consider the data type:
`data Ctree a = Cnil | Ctree a Int (Ctree a) (Ctree a)`
Make this data structure an instance of `Foldable`. The `Int` value represents a count and should not be included in the fold.

---

### **Part 5: The `Applicative` Typeclass**

The `Applicative` typeclass sits between `Functor` and `Monad`. It allows you to apply a wrapped function to a wrapped value. You must implement `pure` and `<*>`.

**Exercise 29: `Applicative` for `Maybe`**
The `Maybe a` type (`Just a | Nothing`) is a perfect introduction to `Applicative`. Make it an instance of `Applicative`. `pure` should wrap a value in `Just`. What should happen if either the function or the value is `Nothing`?

**Exercise 30: `Applicative` for a `LinkedList`**
Make the `LinkedList a` from Exercise 5 an instance of `Applicative`. The standard behavior for lists is that `<*>` applies every function in the first list to every value in the second list, creating a "cartesian product" of results.

**Exercise 31: A "Zip-like" `Applicative`**
Let's re-implement the `Applicative` instance for `LinkedList a`, but this time with a "zip-like" behavior. `(<*>)` should apply the first function to the first value, the second function to the second value, and so on. The resulting list should be as long as the shorter of the two input lists.

**Exercise 32: `Applicative` for `Expr` (from 2024.01.11 & 2024.02.02)**
Make the `Expr a` from Exercise 19 an instance of `Applicative`. You will need to decide on a sensible implementation for what `Op f g <*> x` means. The exam solution provides one possible interpretation.

**Exercise 33: A Zip-like `Applicative` for a Binary Tree (from 2023.02.15)**
The exam asks for a zip-like `Applicative` for a `BBtree`:
`data BBtree a = BBnil | BBtree (BBtree a) a a (BBtree a)`
Implement `Applicative` such that `<*>` combines two trees structurally. For example:
`(BBtree l f1 f2 r) <*> (BBtree l' v1 v2 r')` should result in
`BBtree (l <*> l') (f1 v1) (f2 v2) (r <*> r')`
What should happen if the structures don't match (e.g., `BBnil <*> BBtree ...`)?

**Exercise 34: `Applicative` for a `Tape` (from 2023.01.25)**
Given the following data type for a Turing Machine tape:
`data Tape a = Tape [a] a [a]` -- (left-of-head, at-head, right-of-head)
Implement a zip-like `Applicative` instance. The function should apply to the elements at the head and then zip the left and right tapes.

**Exercise 35: `Applicative` for `Fpair` (from 2022.06.16)**
Make the `Fpair s a` from Exercise 18 an instance of `Applicative`.
You will need to define how `<*>` behaves for all combinations of the `Fpair` and `Pair` constructors.

**Exercise 36: `Applicative` for a Three-Parameter Type (from 2024.07.03)**
Consider the datatype: `data T x y z = T (x -> y -> z)`.
Make `T x y` an instance of `Applicative`. Follow the types:
-   `pure :: a -> T x y a`
-   `<*>` :: T x y (a -> b) -> T x y a -> T x y b`

**Exercise 37: `Applicative` for `W` (from 2024.06.06)**
Consider the datatype: `data W x y = W ([x] -> [y])`.
This wraps a function from a list of `x` to a list of `y`. Make `W x` an instance of `Applicative`.
-   `pure :: a -> W x a`
-   `<*>` :: W x (a -> b) -> W x a -> W x b`

---

### **Part 6: Introduction to `Monad`**

A `Monad` allows for sequencing operations. You must implement `>>=`.

**Exercise 38: A `Monad` for `Maybe`**
Make the `Maybe a` type from Exercise 29 an instance of `Monad`. The `>>=` (bind) operator takes a wrapped value and a function that returns a *new* wrapped value, allowing for computations to be chained together.

**Exercise 39: `Monad` for a `LinkedList`**
Make the `LinkedList a` from Exercise 5 an instance of `Monad`. `xs >>= f` should apply `f` to every element in `xs` and concatenate the resulting linked lists together.

**Exercise 40: `Monad` for the `Expr` type (from 2024.01.11 & 2024.02.02)**
Make the `Expr a` from Exercise 19 an instance of `Monad`. `>>=` takes an expression and a function `f` that transforms a value `a` into a new `Expr b`. The `f` function should be applied wherever a `Var a` appears, effectively substituting a variable with a whole new expression.

Of course. We will now move into more advanced applications of the typeclasses you've learned, tackle the most complex data structures from the exams, and write crucial utility functions.

This block of exercises will push you to combine concepts. You won't just be implementing a `Monad`; you'll be thinking about *why* you'd use one and what its behavior should be for a complex, custom structure.

---

### **Part 7: Advanced `Monad` Implementations**

These exercises involve more complex data types, where the monadic implementation has interesting consequences.

**Exercise 41: `Monad` for a List with Length (`Slist`) (from 2021.08.31)**
Make the `Slist a` from Exercise 9 an instance of `Monad`.
`data Slist a = Slist Int [a]`
The challenge here is to correctly compute the length of the resulting `Slist`. Remember that `xs >>= f` applies `f` to each element and then joins the results. How do you combine the lengths of all the generated lists? *Hint: you might need to convert back and forth from `[a]` using `makeSlist`.*

**Exercise 42: A State-and-Maybe `Monad` (`F`) (from 2024.02.02)**
This is a challenging but insightful problem. Consider the datatype:
`data F b a = F (b -> b) a | Null`
Make `F b` an instance of `Monad`.
-   `pure :: a -> F b a`
-   `>>=` :: F b a -> (a -> F b c) -> F b c
Think of this as a computation that might fail (`Null`) or might succeed with a value (`a`) and a function to update some state (`b -> b`). The monadic bind `>>=` should chain these computations, composing the state-updating functions.

**Exercise 43: A `Monad` for `Deque` (from 2022.07.06)**
Make the `Deque a` from Exercise 27 an instance of `Monad`.
`data Deque a = Deque [a] [a]`
As with `Foldable`, using a `toList` helper function, applying the standard list monad, and then converting back with a `fromList` helper is the most straightforward approach.

**Exercise 44: A `Monad` for the `W` Function Wrapper (from 2024.06.06)**
Make the `W x` type from Exercise 37 an instance of `Monad`.
`data W x y = W ([x] -> [y])`
-   `>>=` :: W x a -> (a -> W x b) -> W x b
This is tricky. `(W g) >>= f` means you have a function `g :: [x] -> [a]` and another function `f :: a -> W x b`. You need to produce a final function of type `[x] -> [b]`. This involves running `g`, then for each resulting `a`, applying `f` to get a new function, and then figuring out how to combine all those resulting functions.

**Exercise 45: The `State` Monad**
The `State` monad is not a data type itself, but a wrapper around a function: `newtype State s a = State { runState :: s -> (a, s) }`. It represents a computation that takes an initial state `s` and produces a result `a` and a new state `s`. Implement `Functor`, `Applicative`, and `Monad` for `State s`. This is a classic exercise and fundamental to understanding state management in Haskell.

---

### **Part 8: Modeling and Manipulating Complex Data**

This section focuses on defining and working with the specific, often unusual, data structures presented in the exams.

**Exercise 46: The `D2L` Data Structure (from 2023.07.03)**
Define a data structure `D2L a` that can store a list of items, where each item is either a single value of type `a` or a list `[a]`. Implement a `flatten` function:
`flatten :: D2L a -> [a]`
This function should produce a single flat list containing all the stored values in order.

**Exercise 47: Partitioned List (`Part`) (from 2023.06.12)**
Define a data structure `Part a` that stores a pivot value of type `a`, a list of elements less than or equal to the pivot, and a list of elements greater than the pivot.
Write the following two functions:
-   `checkpart :: Ord a => Part a -> Bool` (checks if the partition is valid)
-   `list2part :: Ord a => a -> [a] -> Part a` (partitions a list given a pivot)

**Exercise 48: Two-Values/Two-Lists (`Tvtl`) (from 2022.01.21)**
Define a data structure `Tvtl a` which can store *either* two values of type `a` *or* two lists of type `[a]`. Then, make it an instance of `Functor` and `Foldable`.

**Exercise 49: Binary Tree with a State-Monad Map (from 2021.01.20)**
Given the standard binary tree (`data Tree a = Empty | Branch (Tree a) a (Tree a)`), define a *monadic map* for it using the `State` monad you defined in Exercise 45:
`mapTreeM :: Monad m => (a -> m b) -> Tree a -> m (Tree b)`
This function is like `fmap`, but the mapping function `(a -> m b)` can have monadic effects (like modifying state).

**Exercise 50: The `depth_tree` Function (from 2021.01.20)**
Using `mapTreeM` from the previous exercise, define the function `depth_tree`. This function takes a tree of values and returns a tree of the same shape, but each node's value is replaced by a list of all elements encountered in a depth-first traversal up to that node.
Example: For the tree `(Branch (Branch Empty 1 Empty) 2 Empty)`, the result should be `(Branch (Branch Empty [1] Empty) [1,2] Empty)`.
*Hint: The monadic action at each node will be to get the current state (the list of visited nodes), append the current node's value, and then update the state.*

**Exercise 51: Modeling a Multi-Valued Map (from 2021.02.08)**
Define a `Multimap k v` that associates a key of type `k` with a list of values of type `v`. Use a list of `Multinode k v` where `data Multinode k v = Multinode { key :: k, values :: [v] }`.
Implement the following functions:
-   `insert :: Eq k => k -> v -> Multimap k v -> Multimap k v`
-   `lookup :: Eq k => k -> Multimap k v -> [v]`
-   `remove :: Eq v => v -> Multimap k v -> Multimap k v` (removes all occurrences of a value, across all keys)

**Exercise 52: Modeling a Tree with Subtree Counts (from 2022.09.01)**
Define a binary tree `Ctree a` where each node stores data of type `a` *and* the total number of nodes in its own subtree (including itself). Write a smart constructor `cnode` that automatically computes the count.
`cnode :: a -> Ctree a -> Ctree a -> Ctree a`

**Exercise 53: A Parametric Sum Type (`PTL`) (from 2025.06.16)**
Define the datatype `PTL a = P a a | T a a a | L [PTL a]`. Describe what this structure could be used for. Then, make it an instance of `Functor` and `Foldable`. For `Foldable`, you will need to handle the recursion in the `L` constructor carefully.

**Exercise 54: The Hamming Numbers Sequence (from 2025.07.03)**
Hamming numbers are numbers of the form 2<sup>i</sup> * 3<sup>j</sup> * 5<sup>k</sup>. Define an infinite list `hamming :: [Integer]` that contains all Hamming numbers in increasing order.
*Hint: The list starts with 1. The rest of the list is generated by merging three other lists: `(map (*2) hamming)`, `(map (*3) hamming)`, and `(map (*5) hamming)`. You will need an efficient 3-way merge helper function.*

**Exercise 55: The `btrees` Function (from 2023.09.12)**
Define a function `btrees :: a -> [Tree a]` which returns an infinite list of complete binary trees. The first tree is a `Leaf a`. The second is a `Branch (Leaf a) (Leaf a)`. The third has one more level, and so on. All leaves in all trees should contain the given value `a`.

---

### **Part 9: Traversals and Utility Functions**

**Exercise 56: General Tree to List (`gtree2list`) (from 2022.02.10)**
Write a function `gtree2list :: Gtree a -> [a]` that converts the general tree from Exercise 7 into a list using a pre-order traversal (root, then children).

**Exercise 57: Finding the Maximum (`bbmax`) (from 2023.02.15)**
For the `BBtree` from Exercise 33, define a function `bbmax :: Ord a => BBtree a -> Maybe a`. It should return `Just` the maximum element in the tree, or `Nothing` if the tree is empty.

**Exercise 58: A Generalized Zip (`gzip`) (from 2021.07.14)**
Write a function `gzip :: [[a]] -> [[a]]` that takes a list of lists (which may be infinite) and transposes it. For example, `gzip [[1,2,3],[4,5,6],[7,8,9]]` should return `[[1,4,7],[2,5,8],[3,6,9]]`.

**Exercise 59: Sum of Two Greatest (from 2021.07.14)**
Using `gzip` from the previous exercise, write a function `sum_two_greatest :: (Ord a, Num a) => [[a]] -> [a]`. This function should find the sum of the two largest elements in each of the inner lists of the *transposed* matrix.

**Exercise 60: Breadth-First Traversal of an Encoded Tree (from 2025.01.20)**
A binary tree can be encoded as a nested list, e.g., `(1 (2 (4) (5)) (3 (6) (7)))`. Assuming you have a suitable Haskell `data` representation for this, write a *tail-recursive* function to traverse the tree breadth-first, returning a list of its elements.
Example result: `[1, 2, 3, 4, 5, 6, 7]`.
*Hint: Tail recursion in Haskell is often achieved using an accumulator. For a breadth-first search, the "accumulator" is a queue of nodes to visit next.*

Of course. This next set of 20 exercises moves into more advanced territory. We will explore the subtle differences between `Applicative` and `Monad`, tackle the most complex data structures and transformations from your exams, and introduce classic monadic patterns like `State` and `Writer` from first principles.

These exercises are designed to solidify your understanding and prepare you for the most challenging combinations of topics.

---

### **Part 10: Deeper into `Applicative` and `Monad`**

This section focuses on contrasting the two typeclasses and exploring their unique strengths and patterns.

**Exercise 61: Applicative for Error Accumulation**
A great use of `Applicative` is collecting all possible errors, rather than failing on the first one. Using the `Either [String] a` type, implement a validation function for a simple `User` record.
`data User = User { name :: String, age :: Int }`
`validateUser :: String -> Int -> Either [String] User`
Your function should check that the name is not empty and the age is positive. If both are invalid, it should return a list containing *both* error messages in the `Left` constructor.
*Hint: You'll need `pure`, `<*>`, and a helper function for each check that returns an `Either [String] a`.*

**Exercise 62: Monad for Fail-Fast Error Handling**
Now, contrast the previous exercise by using the `Monad` instance for `Either String a`. Write a new validation function:
`validateUserMonadic :: String -> Int -> Either String User`
This version should "fail fast"—it should return only the *first* error message it encounters. This exercise will make the difference between applicative and monadic composition crystal clear.

**Exercise 63: The Reader Monad (`(->) r`)**
The function type `(->) r` (a function that takes an `r` and returns something) can be made an instance of `Functor`, `Applicative`, and `Monad`. This is known as the Reader monad, used for providing a shared, read-only environment. Implement the instances:
-   `instance Functor ((->) r) where fmap = ...` *(Hint: it's just function composition)*
-   `instance Applicative ((->) r) where pure = ...; (<*>) = ...`
-   `instance Monad ((->) r) where (>>=) = ...`
This is a classic, mind-bending exercise that will deepen your understanding of these abstractions.

**Exercise 64: Monadic Sequencing with `>>`**
The `>>` operator is a simplified version of `>>=`, defined as `m1 >> m2 = m1 >>= \_ -> m2`. It's used when you want to perform monadic actions in sequence but discard the result of the first one. Write a function `printAndGetLine :: IO String` that first prints the string "Enter your name:" to the console and then reads a line from the input. Use the `>>` operator.

**Exercise 65: Concatenation-Map (`ltconcmap`) (from 2021.06.22)**
In the exam, a function `ltconcmap` is defined for the `BTT` type from Exercise 24. It behaves like `concatMap` for lists. First, define the concatenation operator for `BTT`:
`(<++>) :: BTT a -> BTT a -> BTT a`
Then, using `<++>` and `fmap`, implement:
`ltconcmap :: (a -> BTT b) -> BTT a -> BTT b`
This shows how monadic-style composition (`bind`) is built from `map` and `join` (or in this case, a custom concatenation).

---

### **Part 11: Advanced Data Structure Manipulation**

This section features challenging transformations and queries on the custom data structures from your exams.

**Exercise 66: Evaluating an Expression Tree**
Using the `Expr a` type from Exercise 19, write an evaluation function.
`eval :: (a -> Maybe Int) -> Expr a -> Maybe Int`
This function takes a lookup function (to get the value of a variable) and an expression, and it should return `Just` the result or `Nothing` if any variable is not found. You'll need to handle the `Op` constructor by defining what the operation is (e.g., addition).

**Exercise 67: Infinite List of Incrementing Trees (`incBtrees`) (from 2023.09.12)**
Define the infinite list `incBtrees :: [Tree Integer]`.
This list is like `btrees` from Exercise 55, but the first tree is a `Leaf 1`, the second is a `Branch (Leaf 2) (Leaf 2)`, the third has leaves of value 3, and so on. This requires combining `fmap` with the generation of an infinite list.

**Exercise 68: Infinite List of Node Counts (`counts`) (from 2023.09.12)**
Write the function `counts :: [Integer]`. This function should return an infinite list containing the total number of nodes for each tree in the `incBtrees` list from the previous exercise. For example, the list should start `[1, 3, 7, 15, ...]`.

**Exercise 69: [Challenge] A Functor for a Circular List (from 2025.02.06)**
The standard `deriving Functor` doesn't work for a circular list due to the recursion.
`data Clist a = Node a (Clist a) | End (Clist a)`
Implement the `Functor` instance for `Clist a` manually. You cannot convert to a standard list and back.
*Hint: You will need to use a `let` binding to create the "knot" for the circular reference in the newly created structure. A recursive helper function is essential.*

**Exercise 70: [Challenge] An Applicative for a Circular List (from 2025.02.06)**
This is even trickier. Implement the `Applicative` instance for `Clist a`. `pure` should create a single-element circular list. `<*>` should combine two circular lists using zip-like behavior. This will test your understanding of lazy evaluation and recursive bindings to its limits.

**Exercise 71: Transposing a "List of Lists" Data Structure (`D2L`)**
Using the `D2L a` structure from Exercise 46, write a function `transposeD2L :: D2L a -> D2L a` that behaves like `gzip` (Exercise 58), treating each item (`D2Cons1` or `D2Cons2`) as a row.

**Exercise 72: A Saner `show` for `Clist`**
Implement an instance of `Show` for `Clist a` that doesn't loop forever. It should detect that it has completed a full circle and stop, perhaps indicating the loop with "...". You will need a helper function that keeps track of the nodes it has already visited.

---

### **Part 12: Working with Monadic Context**

These final exercises put everything together, using monads to solve problems involving state, logging, and complex control flow.

**Exercise 73: Implementing `mapTreeM` from Scratch (from 2021.01.20)**
We used this function before, now it's time to write it. For a standard `Tree a`, implement the monadic map function:
`mapTreeM :: Monad m => (a -> m b) -> Tree a -> m (Tree b)`

**Exercise 74: Labeling a Tree with `State`**
Using `mapTreeM` and the `State` monad (from Exercise 45), write a function `labelTree :: Tree a -> Tree (a, Int)`. This function should traverse the tree and pair each original value with a unique integer label (0, 1, 2, ...).

**Exercise 75: Implementing the `Writer` Monad**
The `Writer` monad is used for accumulating a log alongside a computation.
`newtype Writer w a = Writer { runWriter :: (a, w) }`
Implement `Functor`, `Applicative`, and `Monad` for `Writer w`, with the constraint that `w` must be a `Monoid` (so you can use `mappend` or `<>` to combine logs).

**Exercise 76: Logging a Tree Traversal**
Using your `Writer` monad and `mapTreeM`, write a function `logTraversal :: Show a => Tree a -> (Tree a, [String])`. The function should return the original tree untouched, but the "log" part of the `Writer` should contain a list of the string representations of the nodes as they were visited.

**Exercise 77: Making `Slist` an Applicative**
Make the `Slist a` from Exercise 9 an instance of `Applicative`.
`data Slist a = Slist Int [a]`
The `<*>` operation should behave like the list instance, but you need to correctly calculate the final length. If the function list has length `m` and the value list has length `n`, what is the length of the resulting list?

**Exercise 78: Left and Right Moves on a `Tape` (from 2023.01.25)**
For the `Tape a` from Exercise 34, implement the `left` and `right` functions:
-   `left :: Tape a -> Tape a` (moves the head left)
-   `right :: Tape a -> Tape a` (moves the head right)
You need to handle the edge case where you move off the end of the known tape. The exam implies a concept of a "blank" symbol. Modify the `Tape` definition to include a blank symbol and use it when extending the tape.

**Exercise 79: The `F` Datatype as `Applicative` (from 2024.02.02)**
We implemented the `Monad` for `F b a` in Exercise 42. Now, implement the `Applicative` instance.
`data F b a = F (b -> b) a | Null`
This will help you see how the composition of the state functions (`b -> b`) works in the applicative context versus the monadic one.

**Exercise 80: Final Capstone: `BBtree` Applicative and Its Limits**
You implemented a zip-like `Applicative` for `BBtree` in Exercise 33. In a comment block, explain why this zip-like implementation cannot be extended to a valid `Monad`. What monadic law would it break and why? This requires thinking about how `>>=` would have to discard structure to satisfy the laws, which would violate the "zip-like" nature.

Of course. This final set of 20 exercises is the "boss level." It focuses on the most abstract and challenging problems from your exams, requiring you to synthesize everything you've learned. We will tackle multi-parameter typeclasses, advanced monadic patterns, and problems that require a deep understanding of Haskell's type system and evaluation model.

Passing this section means you are more than ready for your exam.

---

### **Part 13: Advanced Typeclass Instances & Multi-Parameter Types**

These exercises involve creating instances for complex, non-standard data types, often with multiple type parameters, which tests your ability to follow the types and satisfy the laws.

**Exercise 81: `Applicative` for the Three-Parameter `T` (from 2024.07.03)**
We've made `T x y` an `Applicative`. Now, let's complete the set for `data T x y z = T (x -> y -> z)`.
Implement the `Functor` and `Monad` instances for `T x y`.
-   `instance Functor (T x y) where fmap = ...`
-   `instance Monad (T x y) where (>>=) = ...`
This will require careful management of the function inside the `T` constructor.

**Exercise 82: Why Can't `Llist b` Be an `Applicative`? (from 2024.09.03)**
The exam states that `Llist b a` (from Exercise 8) cannot be made an instance of `Applicative` as it is.
`data Llist b a = Nod a b (Llist b a) | Nul`
In a comment, explain why. Specifically, what is the problem with trying to implement `pure :: a -> Llist b a`?

**Exercise 83: Making `Llist Bool` an `Applicative` (from 2024.09.03)**
The constraint from the previous exercise can be resolved if we fix the type of `b`. The exam asks to make `Llist Bool` an `Applicative`.
-   First, define `type LlistBool a = Llist Bool a`.
-   Then, implement the `Applicative` instance for `LlistBool`. You now *can* implement `pure` because you have a default `Bool` value you can use (e.g., `True`).

**Exercise 84: `Functor` and `Applicative` for `PTL` (from 2025.06.16)**
For the complex sum type `data PTL a = P a a | T a a a | L [PTL a]` from Exercise 53, implement the `Applicative` instance.
`pure` is straightforward. The main challenge is defining `<*>` for all nine possible combinations of constructors (`P <*> P`, `P <*> T`, `T <*> L`, `L <*> L`, etc.). You must decide on a sensible behavior for each case. The simplest approach is often to have most combinations result in an empty `L []`.

**Exercise 85: The `Functor` Instance for `W x` (from 2024.06.06)**
We jumped straight to `Applicative` and `Monad` for `data W x y = W ([x] -> [y])` in earlier exercises. For completeness, implement the `Functor` instance. This is a good warm-up for the more complex instances and helps solidify the pattern.
-   `instance Functor (W x) where fmap = ...`

---

### **Part 14: Complex Data Transformations and Algorithms**

This section is about writing functions that perform non-trivial algorithms on the custom data structures.

**Exercise 86: A Deep Reverse Function (`deeprev`) (from 2023.07.03)**
Haskell lists can contain other lists (`[[1], [2,3]]`). To handle this, we need a custom data type.
`data DeepList a = DList [DeepList a] | DVal a`
Write a function `deeprev :: DeepList a -> DeepList a`. This function should reverse the list at every level of nesting.
Example: `DList [DVal 1, DList [DVal 2, DVal 3]]` becomes `DList [DList [DVal 3, DVal 2], DVal 1]`.

**Exercise 87: Mapping and Reversing (`deepmaprev`) (from 2025.06.16)**
Using the `DeepList` type from the previous exercise, write a function that also applies a function to every non-list element.
`deepmaprev :: (a -> b) -> DeepList a -> DeepList b`

**Exercise 88: The `multi-list->vector` Transformation (from 2021.01.20)**
The Scheme exam asks to convert a nested list into a nested "vector". We can model this in Haskell by converting a `DeepList a` (from Exercise 86) into a `DeepVector a`.
`data DeepVector a = VVector (Vector (DeepVector a)) | VVal a deriving Show`
Write the conversion function: `deepListToVector :: DeepList a -> DeepVector a`. You will need to import `Data.Vector`.

**Exercise 89: Checking for Contained Length (`contains-length?`) (from 2025.07.03)**
This Scheme problem can be modeled in Haskell. Define a data type for a list that may contain its own length as an element.
`data LengthList = LenList [Either Int LengthList]`
(We use `Either` to distinguish numbers from sub-lists). Write a function `containsLength :: LengthList -> Bool`. This function must be true if and only if every list (and sub-list) contains its own length as one of its `Int` elements.

**Exercise 90: Depth Encoding (`depth-encode`) (from 2021.02.08)**
This function takes a nested list and returns a flat list where each element is paired with its nesting depth.
Using `DeepList a` from Exercise 86, write:
`depthEncode :: DeepList a -> [(a, Int)]`
A helper function `go :: Int -> DeepList a -> [(a, Int)]` will be essential, where the `Int` parameter tracks the current depth.

---

### **Part 15: Final Review & Exam-Style Problems**

This is the final stretch. These problems are structured exactly like the exam questions, often requiring you to define a type and then implement multiple typeclass instances for it.

**Exercise 91: Exam Problem (2025.01.20 Style)**
1.  Define a data structure `Trio a` which is a 3-tuple `(a, a, a)`.
2.  Make `Trio` an instance of `Functor`.
3.  Make `Trio` an instance of `Applicative`, where `<*>` applies component-wise.
4.  Implement a function `zipTrio :: Trio a -> Trio b -> Trio (a, b)`.

**Exercise 92: Exam Problem (2023.02.15 Style)**
Consider a binary tree where data is stored only at the leaves.
`data LeafTree a = Leaf a | Node (LeafTree a) (LeafTree a)`
1.  Make `LeafTree` an instance of `Functor`, `Foldable`, `Applicative`, and `Monad`.
2.  For `Applicative`, `pure` should create a `Leaf`. `Node f1 f2 <*> Node v1 v2` should result in `Node (f1 <*> v1) (f2 <*> v2)`. What should happen in other cases?
3.  Explain what `(>>=)` does in your implementation with a concrete example.

**Exercise 93: Exam Problem (2022.06.16 Style)**
A "fancy maybe" type stores an optional value `a` along with a potential log of type `s`.
`data LoggedMaybe s a = Nothing | Just a s`
1.  Make `LoggedMaybe s` an instance of `Show` where `Just 5 "success"` shows as `"Just 5 (logged: success)"`.
2.  Make `LoggedMaybe s` an instance of `Eq` where the log is ignored for comparison.
3.  Make `LoggedMaybe s` an instance of `Functor`.
4.  Make `LoggedMaybe s` an instance of `Applicative`, where logs are combined using `mappend` (from `Monoid`).

**Exercise 94: Exam Problem (2024.01.11 Style)**
Consider a data type for a computation that can be a single value, a pair of computations, or a computation dependent on a boolean choice.
`data Comp a = Val a | Pair (Comp a) (Comp a) | If Bool (Comp a) (Comp a)`
1.  Make `Comp` an instance of `Functor`.
2.  Make `Comp` an instance of `Applicative`. `pure` should be `Val`. Define a reasonable behavior for `<*>`.
3.  Write a function `runComp :: Comp a -> [a]` that evaluates the computation and returns all possible resulting values in a list.

**Exercise 95: Exam Problem (2025.02.06 Style)**
A "sentinel list" has a special `End` node but no data. Data is stored in `Cons` nodes.
`data SList a = End | Cons a (SList a)`
1.  Describe its possible usage.
2.  Make `SList` an instance of `Functor` and `Foldable`.
3.  Make `SList` an instance of `Applicative`, where `pure x = Cons x End`.
4.  Explain why you cannot make a lawful `Monad` instance for `SList` that is consistent with your `Applicative` instance without breaking a monad law (specifically, `pure x >>= f` should be `f x`).

**Exercise 96: A Tree with Alternating Data**
Define a tree that holds values of type `a` at even depths and values of type `b` at odd depths.
`data AltTree a b = Leaf a | Branch b (AltTree b a) (AltTree b a)`
Implement `fmap` for this structure. Note that it won't be a standard `Functor`. You'll need `bimap :: (a -> c) -> (b -> d) -> AltTree a b -> AltTree c d`. This is a `Bifunctor`.

**Exercise 97: A List of Functions**
Consider `data FunList a b = FNil | FCons (a -> b) (FunList a b)`. This is a list of functions.
1. Make `FunList a` an instance of `Applicative`. How would `pure` work? What about `<*>`? This is highly abstract.
2. Write a function `applyAll :: FunList a b -> a -> [b]` which applies a value `a` to every function in the list and returns a list of results.

**Exercise 98: A Free Monad (simplified)**
The Free monad allows you to build monadic syntax around any `Functor`.
`data Free f a = Pure a | Free (f (Free f a))`
1. Make `Free f` an instance of `Functor`.
2. Make `Free f` an instance of `Monad`, where `f` is a `Functor`.
This is one of the most important advanced Haskell patterns. Getting this right demonstrates true mastery of recursive types and typeclasses.

**Exercise 99: The `contains-length?` Challenge Revisited**
Go back to Exercise 89. Can you write a version of the check that is *monadic*? For example, using the `Writer` monad to log which lists were checked, or the `State` monad to avoid re-checking shared sub-structures if the list were a graph. Sketch out how you would approach this.

**Exercise 100: Design Your Own Exam Problem**
Based on all the past exams, design your own Haskell exercise.
1.  Invent a novel data structure.
2.  Describe its purpose.
3.  Ask for `Functor`, `Foldable`, and `Applicative` instances.
4.  Ask for one non-trivial utility function that operates on your data structure.
Solving your own problem is the ultimate test of understanding.
