% Define a function which takes two list of PIDs [x1, x2, ...], [y1, y2, ...],
% having the same length, and a function f, and creates a different "broker"
% process for managing the interaction between each pair of processes xi and
% yi.
% At start, the broker process i must send its PID to xi and yi with a message
% {broker, PID}. Then, the broker i will receive messages {from, PID, data, D}
% from xi or yi, and it must send to the other one an analogous message, but
% with the broker PID and data D modified by applying f to it. A special stop
% message can be sent to a broker i, that will end its activity sending the
% same message to xi and yi.


% wrong, my solution
% create_broker(List1, List2, f) ->
%   receive
%     bla bla
%   end.
%
% broker(f) ->
%   receive
%     {from, PID, data, D} ->
%       PID ! {from, f(PID), data, f(D)},
%       broker(f)
%     stop ->
%       nothing()


% the professor's solution

broker(X, Y, F) ->
  X ! {broker, self()},
  Y ! {broker, self()},
  receive
    {from, X, data, D} ->
      Y ! {from, self(), data, F(D)},
      broker(X, Y, F);
    {from, Y, data, D} ->
      X ! {from, self(), data, F(D)},
      broker(X, Y, F);
    stop ->
      X ! stop,
      Y ! stop,
      ok
  end.

twins([],_,_) ->
  ok;

twins([X|Xs],[Y|Ys],F) ->
  spawn(?MODULE, broker, [X, Y, F]),
  twins(Xs, Ys, F).
