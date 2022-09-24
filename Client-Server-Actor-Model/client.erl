-module(client).
-export([beginWork/2]).

% This actor function requests the master for a range of numbers to be appended to the ID.
beginWork(MID, Zs) ->
    MID ! {self(), {range}},
    receive
        {MID, {RangeL, RangeR}} -> findHash(RangeL, RangeR, MID, Zs)
    end.

% This function loops through the range messagd by the master.
findHash(S, E, MID, Z) ->
    case S < E of
        true ->
            checkString(S, Z, MID),
            findHash(S + 1, E, MID, Z);
        false ->
            beginWork(MID, z)
    end.

% This function is used to check if a block addess meets the requirements.
% If a block address meets the requirements, the actor sends the address to the master, where it is printed.
checkString(N, Z, MID) ->
    BitcoinKey = "a.patil:" ++ integer_to_list(N),
    <<BKey:256>> = crypto:hash(sha256, BitcoinKey),
    SHA_String = io_lib:format("~64.16.0b", [BKey]),
    case (string:substr(SHA_String, 1, Z) == string:left("", Z, $0)) of
        true ->
            MID ! {self(), {BitcoinKey, SHA_String}};
        false ->
            done
    end.
