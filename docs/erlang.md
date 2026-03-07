# Erlang Cheatsheet

* Table of Contents
{:toc}

## Basic Syntax

### Variables and Atoms
- **Variables** must start with an uppercase letter or an underscore (e.g., `X`, `MyVar`, `_Unused`).
- **Atoms** must start with a lowercase letter (e.g., `ok`, `error`, `my_atom`).

### Function Definition
```erlang
% Function definition
-module(math).
-export([add/2]).

add(X, Y) ->
    X + Y.
```
