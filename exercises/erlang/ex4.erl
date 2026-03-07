% Exercise 4: The Ping-Pong Processes Write a function start_ping_pong/0 that spawns two processes, a "ping" process and a "pong" process.

% The "ping" process sends the message {ping, self()} to the "pong" process.
% When the "pong" process receives a ping message, it prints "Pong received ping" and sends back a {pong, self()} message to the "ping" process.
% When the "ping" process receives a pong message, it prints "Ping received pong" and sends another ping message to the "pong" process. This should continue for 5 rounds, after which both processes should terminate.

-module(ex3).
-export([start/0]).

start() ->
  spawn(fun() -> ping_send() end),
  spawn(fun() -> pong() end).

ping_send() ->
  Pid_pong ! {ping, self()},
  ping().

ping() ->
  receive
    {pong, Pid} ->
      Pid ! {ping, self()}
  end.

pong() ->
  receive
    {ping, Pid} ->
      io:format("Ping received pong."),
      Pid ! {pong, self()},
      pong()
  end.
