-module(server).
-import(math, [pow/2]).
% -import(actors, [beginWork/2]).
-import(client, [beginWork/2]).
-export([main/1]).

main(Noz) ->
    % Number of actors, to be selected at random
    RandN = 5,
    % {ok, [Noz]} = io:fread("input : ", "~d"),
    MasterID = spawn(fun() -> endlessLoop(RandN) end),
    generateActors(MasterID, Noz, RandN).

endlessLoop(Rn) ->
    receive
        {AID, {range}} ->
            End = Rn + round(pow(10, 6)),
            AID ! {self(), {Rn, End}},
            endlessLoop(End + round(pow(10, 6)));
        {AID, {BTC, SHA_String}} ->
            io:fwrite("Actor ID: ~p Output: ~p  ~p~n", [AID, BTC, SHA_String]),
            endlessLoop(Rn)
    end.

generateActors(MID, Zs, Rn) ->
    spawn(fun() -> beginWork(MID, Zs) end),
    case Rn > 0 of
        true ->
            generateActors(MID, Zs, Rn - 1);
        false ->
            ok
    end.
