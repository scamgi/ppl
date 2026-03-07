% Exercise 5: The Countdown Timer Write a function countdown/1 that takes an integer N > 0. It should immediately send the atom tick to its own message queue, then wait to receive it. Upon receiving tick, it should print the current value of N, and if N > 1, it should recursively call itself with N-1. If N is 1, it should print 1 and then terminate. This exercise simulates a timed loop without using timer:sleep/1.

-module(ex5).
-export(start_countdown/0).

start_countdown() ->
  spawn(fun() -> countdown(5) end).

countdown(RoundsLeft) when RoundsLeft > 0 ->
  