# Erlang Cheatsheet

* Table of Contents
{:toc}

## Basic Syntax

### Variables and Atoms
- **Variables** must start with an uppercase letter or an underscore (e.g., `X`, `MyVar`, `_Unused`).
- **Atoms** are literal constants where their name is their value (similar to symbols in Ruby or enums in C). They must start with a lowercase letter (e.g., `ok`, `error`, `my_atom`) or be enclosed in single quotes (e.g., `'My Atom'`).

### Tuples
Tuples are compound data types used to store a fixed number of items. They are enclosed in curly braces `{}`.
- **Syntax**: `{Element1, Element2, ...}`
- **Examples**:
  - `{10, 20}` (a pair of coordinates)
  - `{ok, "File content"}` (a tagged tuple, common in Erlang for result handling)
  - `{person, "Alice", 30}` (grouping related data)

### Lists
Lists are ordered collections of terms. They are enclosed in square brackets `[]`.
- **Syntax**: `[Element1, Element2, ...]`
- **Examples**:
  - `[1, 2, 3]` (a list of integers)
  - `["Hello", "World"]` (a list of strings)
  - `[{person, "Alice"}, {person, "Bob"}]` (a list of tuples)
- **Head and Tail**: Lists can be split into a head (first element) and a tail (rest of the list) using the `|` operator: `[Head | Tail]`.

### Comprehensions
List comprehensions provide a concise way to create lists based on existing lists.
- **Syntax**: `[Expression || Generator, Filter, ...]`
- **Examples**:
  - `[X*2 || X <- [1, 2, 3]]` produces `[2, 4, 6]`.
  - `[X || X <- [1, 2, 3, 4], X rem 2 == 0]` produces `[2, 4]` (filters even numbers).

### Maps
Maps are key-value associations enclosed in `#{}`.
- **Syntax**: `#{Key1 => Value1, Key2 => Value2}`
- **Updating**: `Map#{Key => NewValue}` adds or updates a key. `Map#{Key := NewValue}` updates an existing key only.
- **Example**:
  - `M = #{name => "Alice", age => 30}`
  - `M#{age := 31}` results in `#{name => "Alice", age => 31}`

### Pattern Matching
In Erlang, the `=` operator is a pattern match, not an assignment.
- **Matching**: `{A, B} = {1, 2}` binds `A` to `1` and `B` to `2`.
- **Assertions**: `{ok, Result} = call()` will succeed if `call()` returns `{ok, ...}` but crash if it returns `{error, ...}`.
- **Function Heads**: Functions can have multiple clauses matched by pattern.

### Function Calls
- **Local Call**: `my_func(Arg1)` (within the same module).
- **Remote Call**: `module:function(Arg1)` (calling a function in another module).
- **Dynamic Call (`apply`)**: `apply(Module, Function, Args)` calls a function dynamically.
  - `apply(math, add, [1, 2])` is equivalent to `math:add(1, 2)`.
  - Useful when the module or function name is determined at runtime.

### Built-in Functions (BIFs)
Common functions built into the Erlang runtime.
- **Lists**: `length(List)`, `hd(List)`, `tl(List)`.
- **Tuples**: `element(N, Tuple)`, `setelement(N, Tuple, Value)`, `tuple_size(Tuple)`.
- **Conversions**: `atom_to_list(Atom)`, `list_to_integer(List)`, `integer_to_list(Int)`.
- **Process**: `self()` (current PID), `spawn(Fun)`.
- **Time**: `date()`, `time()`, `now()`.

### Function Definition
```erlang
% Function definition
-module(math).
-export([add/2]).

add(X, Y) ->
    X + Y.
```

### Guarded Function Clauses
```erlang
% Return the maximum of X and Y
max(X, Y) when X > Y -> X;
max(_, Y) -> Y.

% Factorial with guards
fact(N) when N > 0 ->
    N * fact(N - 1);
fact(0) ->
    1.
```
