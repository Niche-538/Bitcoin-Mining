% Asks server for work on server's ip address and mine coins
-module(client).
-import(string, [substr/3, equal/2]).
-compile(export_all).

for(_, 0, _, _) ->
  "";
for(Bitcoin, N, Term, NumberOfZeroes) when N > 0 ->
  BitcoinKey = Bitcoin ++ integer_to_list(N),
  SHA = binary:decode_unsigned(crypto:hash(sha256, BitcoinKey)),
  SHA_String = io_lib:format("~64.16.0b", [SHA]),
  Subs = substr(SHA_String, 1, NumberOfZeroes),

  ZeroString = "00000000000000000000000000000000000000000000000000000000000",
  ZeroSubs = substr(ZeroString, 1, NumberOfZeroes),
  case Subs of
    ZeroSubs -> io:fwrite("~p     ~s~n", [BitcoinKey, SHA_String]);
    _Else -> false
  end,
  for(Bitcoin, N + 1, Term, NumberOfZeroes).

actor_call(RangeL, RangeR) ->
  receive
    {From, {zeroes, NumberOfZeroes}} ->
      Bitcoin = "pkamble:",
      From ! {self(), for(Bitcoin, RangeL, RangeR,NumberOfZeroes)},
      actor_call(RangeL, RangeR)
  end.

convert(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {Pid, Response} -> Response
  end.

start_server() ->
  {ok, [NumberOfZeroes]} = io:fread("input : ", "~d"),
  io:format("Number of Zeroes: ~p ~n", [NumberOfZeroes]),
  convert(spawn(fun() -> actor_call(1, 100000) end), {zeroes, NumberOfZeroes}),
  convert(spawn(fun() -> actor_call(100000, 200000) end), {zeroes, NumberOfZeroes}),
  convert(spawn(fun() -> actor_call(200000, 300000) end), {zeroes, NumberOfZeroes}),
  convert(spawn(fun() -> actor_call(400000, 500000) end), {zeroes, NumberOfZeroes}),
  convert(spawn(fun() -> actor_call(500000, 600000) end), {zeroes, NumberOfZeroes}).







