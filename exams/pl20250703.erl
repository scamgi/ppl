runit(Proc, F, Post, X) ->
    V = F(X),
    case Post(V) of
        true ->
            Proc ! {self(), V};
        false -> Proc ! {self(), none}
    end.

recv(none) ->
    none;

recv(Pid) ->
    receive
        {Pid, V} -> V
    end.

filtermap(Pre, F, Post, L) ->
    W = [case Pre(X) of
            true ->
                spawn(?MODULE, runit, [self(), F, Post, X]);
            false ->
                none
        end || X <- L],
    lists:filter(fun (X) -> not (X == none) end, lists:map(fun recv/1, W)).
