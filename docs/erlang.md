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

### Function Definition
```erlang
% Function definition
-module(math).
-export([add/2]).

add(X, Y) ->
    X + Y.
```
