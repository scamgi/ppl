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

### Guard Examples
Guards are expressions that must evaluate to `true` for a clause to be selected.

**Comparison operators:**
```erlang
check(X) when X > 0 -> positive;
check(X) when X < 0 -> negative;
check(X) when X == 0 -> zero.
```

**Type test BIFs:**
```erlang
describe(X) when is_integer(X) -> integer;
describe(X) when is_float(X) -> float;
describe(X) when is_atom(X) -> atom;
describe(X) when is_list(X) -> list;
describe(X) when is_tuple(X) -> tuple;
describe(X) when is_map(X) -> map;
describe(X) when is_pid(X) -> process_id.
```

**Combining guards with `,` (and) and `;` (or):**
```erlang
% Both conditions must be true (logical AND)
in_range(X) when X >= 0, X =< 100 -> true;
in_range(_) -> false.

% Either condition can be true (logical OR)
is_zero_or_one(X) when X == 0; X == 1 -> true;
is_zero_or_one(_) -> false.
```

**Using `andalso` and `orelse`:**
```erlang
% Short-circuit evaluation
safe_div(X, Y) when is_number(X), is_number(Y), Y =/= 0 -> X / Y;
safe_div(_, _) -> error.
```

**Common guard BIFs:**
```erlang
% Length and size checks
process(L) when length(L) > 3 -> long_list;
process(T) when tuple_size(T) == 2 -> pair;
process(M) when map_size(M) == 0 -> empty_map.

% Arithmetic in guards
is_even(N) when N rem 2 == 0 -> true;
is_even(_) -> false.

% Element access
first_is_ok({ok, _}) -> true;
first_is_ok(T) when element(1, T) == ok -> true;
first_is_ok(_) -> false.
```

## Concurrency

### Processes
Erlang processes are lightweight and isolated.
- **Spawn**: `Pid = spawn(Module, Function, Args)` creates a new process and returns its Process ID (Pid).
- **Self**: `self()` returns the Pid of the current process.

### Message Passing
Communication between processes is done via asynchronous message passing.
- **Send**: `Pid ! Message` sends a message to the process with `Pid`. The operation is non-blocking.
- **Receive**: Wait for messages matching a pattern.
```erlang
receive
    {sender, Msg} ->
        io:format("Received: ~p~n", [Msg]);
    stop ->
        io:format("Stopping...~n")
end.
```

### Example: Ping Pong
```erlang
-module(ping_pong).
-export([start/0, ping/0, pong/0]).

start() ->
    PongPid = spawn(ping_pong, pong, []),
    spawn(ping_pong, ping, [3, PongPid]).

ping(0, PongPid) ->
    PongPid ! finished,
    io:format("Ping finished~n");
ping(N, PongPid) ->
    PongPid ! {ping, self()},
    receive
        pong ->
            io:format("Ping received pong~n")
    end,
    ping(N - 1, PongPid).

pong() ->
    receive
        finished ->
            io:format("Pong finished~n");
        {ping, PingPid} ->
            io:format("Pong received ping~n"),
            PingPid ! pong,
            pong()
    end.
```
