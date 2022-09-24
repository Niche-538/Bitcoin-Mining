-module(server).
-import(math, [pow/2]).
-import(raand, [uniform/1]).
-import(client, [beginWork/2]).
-export([main/1]).

main(Noz) ->
    % Timestamps to check the project runtime.
    T = erlang:timestamp(),
    io:format("Start Time: ~p~n", [T]),

    % Number of actors, to be selected at random
    RandN = uniform(10000),
    MasterID = spawn(fun() -> endlessLoop(RandN) end),
    generateActors(MasterID, Noz, RandN).

% This loop executes endlessly and assigns a range of numbers to an available actor.
endlessLoop(Rn) ->
    receive
        {AID, {range}} ->
            End = Rn + 1000000000,
            AID ! {self(), {Rn, End}},
            endlessLoop(End + 1000000000);
        {AID, {BTC, SHA_String}} ->
            io:format("Actor ID: ~p Output: ~p  ~p~n", [AID, BTC, SHA_String]),
            T = erlang:timestamp(),
            io:format("Find Time: ~p~n", [T]),
            endlessLoop(Rn)
    end.

% This function spawns actors recursively.
generateActors(MID, Zs, Rn) ->
    spawn(fun() -> beginWork(MID, Zs) end),
    case Rn > 0 of
        true ->
            generateActors(MID, Zs, Rn - 1);
        false ->
            done
    end.
