-module(ex1).
-export([echo_server/0]).

%% @doc Spawns the echo server process.
%% The server will print any message it receives to the console.
echo_server() ->
  %% fun means that the thing that is passed is a function
  spawn(fun() -> loop() end).

%% @doc The main loop of the server.
%% It waits for a message, prints it, and then calls itself to wait for the next message.
loop() ->
  receive
    Message ->
      io:format("Server received message: ~p~n", [Message])
  end,
  loop().
