-module(client).
-import(string, [substr/3, equal/2, len/1]).
-export([beginWork/2]).

beginWork(MID, Zs) ->
    MID ! {self(), {range}},
    receive
        {MID, {RangeL, RangeR}} -> findHash(RangeL, RangeR, MID, Zs)
    end.

findHash(S, E, MID, Z) ->
    case S < E of
        true ->
            checkString(S, Z, MID),
            findHash(S + 1, E, MID, Z);
        false ->
            beginWork(MID, z)
    end.

checkString(N, Z, MID) ->
    BitcoinKey = "a.patil:" ++ integer_to_list(N),
    % SHA = binary:decode_unsigned(crypto:hash(sha256, BitcoinKey)),
    SHA_String = io_lib:format("~64.16.0b", [
        binary:decode_unsigned(crypto:hash(sha256, BitcoinKey))
    ]),
    Subs = substr(SHA_String, 1, Z),
    ZeroString = "00000000000000000000000000000000000000000000000000000000000",
    ZeroSubs = substr(ZeroString, 1, Z),
    case equal(Subs, ZeroSubs) of
        true ->
            % io:fwrite("~p       ~p     ~s       ~p~n", [self(), BitcoinKey, SHA_String, MID]);
            MID ! {self(), {BitcoinKey, SHA_String}};
        false ->
            done
    end.
