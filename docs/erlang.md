# Erlang Cheatsheet

* Table of Contents
{:toc}

## Basic Syntax

### Function Definition
```erlang
% Function definition
-module(math).
-export([add/2]).

add(X, Y) ->
    X + Y.
```
