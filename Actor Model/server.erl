-module(server).
-import(string, [substr/3, equal/2]).
-compile(export_all).

for(_, 0, _, _) ->
  "";
for(Bitcoin, N, Term, NumberOfZeroes) when N > 0 ->
  BitcoinKey = Bitcoin ++ integer_to_list(N),
  SHA = binary:decode_unsigned(crypto:hash(sha256, BitcoinKey)),
  SHA_String = io_lib:format("~64.16.0b", [SHA]),
  Subs = substr(SHA_String, 1, NumberOfZeroes),

  ZeroString = "0000000000000000000000000000000000000000000000",
  ZeroSubs = substr(ZeroString, 1, NumberOfZeroes),
  case Subs of
    ZeroSubs -> io:fwrite("~p     ~s~n", [BitcoinKey, SHA_String]);
    _Else -> false
  end,
  for(Bitcoin, N - 1, Term, NumberOfZeroes).


start_server() ->
  {ok, [NumberOfZeroes]} = io:fread("input : ", "~d"),
  io:format("Number of Zeroes: ~p ~n", [NumberOfZeroes]),
  Bitcoin = "pkamble:",
  for(Bitcoin, 5000000, 1,NumberOfZeroes).