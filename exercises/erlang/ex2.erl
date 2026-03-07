% Exercise 2: The Adder Process Create a function adder/1 that takes an initial integer N as an argument. It should then loop, waiting for messages.
%
% If it receives a message of the form {add, X}, it should add X to its current number and continue looping with the new sum.
% If it receives the message {get, Pid}, it should send its current sum back to the process Pid in the format {sum, CurrentSum}.

% this is all wrong
% -module(ex2).
% -export([ex2_server/0]).

% ex2_server() ->
%   spawn(fun() -> loop() end).

% % TO BE CONTINUED
% loop() ->
%   curr = 0
%   receive
%     { add, X } ->
%       curr = curr + X
%     { get, Pid } ->
%       { sum, curr }
%   end,
%   loop().

-module(ex2).
-export([start/1]).

%% @doc Starts the adder process with an initial value N.
start(N) ->
  spawn(fun() -> loop(N) end).

%% @doc The main server loop. It holds the current sum in CurrentSum.
loop(CurrentSum) ->
  receive
    {add, X} ->
      NewSum = CurrentSum + X,
      io:format("Received add ~p, sum is now ~p~n", [X, NewSum]),
      loop(NewSum);  % Loop with the new sum

    {get, Pid} ->
      Pid ! {sum, CurrentSum}, % Send the sum back to the requester
      io:format("Received get request, sent back ~p~n", [CurrentSum]),
      loop(CurrentSum); % Loop with the same sum

    Other ->
      io:format("Unknown message received: ~p~n", [Other]),
      loop(CurrentSum)  % Loop with the same sum
  end.

% % Start the server with an initial value of 10
% 2> AdderPid = adder:start(10).
% <0.82.0>

% % Send a message to add 5
% 3> AdderPid ! {add, 5}.
% Received add 5, sum is now 15
% {add,5}

% % Send another message to add 7
% 4> AdderPid ! {add, 7}.
% Received add 7, sum is now 22
% {add,7}

% % Get the current value. The result will be sent to your shell's Pid
% 5> AdderPid ! {get, self()}.
% Received get request, sent back 22
% {get,<0.78.0>}

% % Check the shell's mailbox to see the reply
% 6> flush().
% Shell got {sum,22}
% ok