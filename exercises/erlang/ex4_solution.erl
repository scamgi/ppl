-module(ex4_solution).
-export([start_ping_pong/0]).

% The main function to start the system.
start_ping_pong() ->
    % Spawn the 'pong' process first so we can get its PID.
    PongPid = spawn(fun() -> pong() end),
    % Spawn the 'ping' process and pass it the PongPid and the number of rounds.
    spawn(fun() -> ping(PongPid, 5) end),
    ok.

% The ping process. It needs to know the pong process's PID and the number of rounds left.
ping(PongPid, RoundsLeft) when RoundsLeft > 0 ->
    io:format("Ping: Sending ping to ~p. Rounds left: ~w~n", [PongPid, RoundsLeft]),
    PongPid ! {ping, self()}, % Send the initial/next ping message.
    receive
        {pong, FromPong} ->
            io:format("Ping: Received pong from ~p.~n", [FromPong]),
            % Recurse with one less round.
            ping(PongPid, RoundsLeft - 1)
    after 1000 -> % Add a timeout in case pong dies.
        io:format("Ping: Did not receive pong in time. Terminating.~n")
    end;

% Base case: When RoundsLeft is 0, the process is done.
ping(_, 0) ->
    io:format("Ping: All rounds complete. Terminating.~n").

% The pong process. It loops indefinitely until the ping process stops sending messages.
pong() ->
    receive
        {ping, FromPing} ->
            io:format("Pong: Received ping from ~p.~n", [FromPing]),
            FromPing ! {pong, self()}, % Send a pong back.
            pong() % Continue the loop to wait for the next ping.
    after 2000 -> % Timeout if no ping is received for 2 seconds.
        io:format("Pong: No ping received. Terminating.~n")
    end.