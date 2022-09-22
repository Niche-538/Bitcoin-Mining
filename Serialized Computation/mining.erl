-module(mining).
-import(string, [substr/3, equal/2]).
-compile(export_all).

for(_, 0, _) ->
    "";
for(S, N, Term) when N > 0 ->
    US = S ++ integer_to_list(N),
    X = binary:decode_unsigned(crypto:hash(sha256, US)),
    Y = io_lib:format("~64.16.0b", [X]),
    % Val = equal(substr(Y, 1, 3), "000"),
    Subs = substr(Y, 1, 5),
    case Subs of
        "00000" -> io:fwrite("~p     ~s~n", [US, Y]);
        _Else -> false
    end,
    for(S, N - 1, Term).

encoding() ->
    Term = string:strip(io:get_line("Prompt: "), right, $\n),
    % NZ = io:read("Enter"),
    S = Term ++ ":",
    for(S, 5000000, 1).
