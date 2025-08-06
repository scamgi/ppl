-module(ex5_solution).
-export([countdown/1]).

%% @doc Starts a new process that counts down from N to 1.
%% The process sends a 'tick' message to itself for each step.
countdown(N) when is_integer(N) andalso N > 0 ->
    spawn(fun() -> loop(N) end).

%% @private
%% The internal loop function that runs within the spawned process.
loop(1) ->
    % Base case: N is 1.
    % Send the message to ourself as required by the exercise.
    self() ! tick,
    receive
        tick ->
            io:format("1~n")
            % After printing, there is no recursive call, so the process terminates.
    end;

loop(N) when N > 1 ->
    % Recursive step: N is greater than 1.
    % Immediately send the 'tick' atom to our own message queue.
    self() ! tick,
    % Wait to receive the message we just sent.
    receive
        tick ->
            % Once received, print the current value of N.
            io:format("~w~n", [N]),
            % Call the function again with N-1 to continue the countdown.
            loop(N - 1)
    end.

