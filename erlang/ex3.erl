% Exercise 3: The Simple Key-Value Store Write a function kv_store(Map) that implements a simple key-value server.

% The process is started with an initial map (e.g., maps:new()).
% It waits for messages:
% {put, Key, Value}: It should store the key-value pair.
% {get, Key, Pid}: It should look up the Key and send {value, Result} back to Pid. Result can be the value found or the atom not_found. The process should continue its loop with the updated map after each operation.

% something wrong...

% -module(ex3).
% -export([kv_store/1]).

% kv_store(Map) ->
%   spawn(fun() -> loop(Map) end).

% loop(Map) ->
%   receive
%     { put, Key, Value } ->
%       Map#{Key => Value};
%     { get, Key, Pid } ->
%       Pid ! Map.Key
%   end,
%   loop(Map).

-module(ex3).
-export([start/1]).

%% @doc Starts the key-value store with an initial map.
%% Use maps:new() to start with an empty store.
start(InitialMap) ->
  spawn(fun() -> loop(InitialMap) end).

%% @doc The main server loop, holding the current map state.
loop(CurrentMap) ->
  receive
    {put, Key, Value} ->
      % Create a new map with the added key/value pair.
      NewMap = maps:put(Key, Value, CurrentMap),
      % Loop again, passing the NEW map as the state.
      loop(NewMap);

    {get, Key, Pid} ->
      % Look up the key. The third argument is the default value to return
      % if the key is not found. This elegantly solves the requirement.
      Result = maps:get(Key, CurrentMap, not_found),
      Pid ! {value, Result},
      % Loop again with the UNCHANGED map.
      loop(CurrentMap);

    Other ->
      io:format("Unknown message received: ~p~n", [Other]),
      loop(CurrentMap)
  end.
