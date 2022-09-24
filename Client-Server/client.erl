-module(client).
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
    <<BKey:256>> = crypto:hash(sha256, BitcoinKey),
    SHA_String = io_lib:format("~64.16.0b", [BKey]),
    % Subs = string:substr(SHA_String, 1, Z),
    % ZeroString = "00000000000000000000000000000000000000000000000000000000000",
    % ZeroSubs = string:substr(ZeroString, 1, Z),
    case (string:substr(SHA_String, 1, Z) == string:left("", Z, $0)) of
        true ->
            MID ! {self(), {BitcoinKey, SHA_String}};
        false ->
            done
    end.
