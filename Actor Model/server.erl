% Server mine coins and when client is available asks client to mine too. Distribute work to clients who ask for work
% All coins are displayed on server

-module(server).
-import(string, [substr/3, equal/2]).
-export([main/0]).

mineCoin(Bitcoin, N, Term, NumberOfZeroes, ServerPID) ->
  case N < Term  of
    true->
      findHash(N,ServerPID,NumberOfZeroes),
      mineCoin(Bitcoin, N + 1, Term, NumberOfZeroes,ServerPID);
    false -> done
  end.

findHash(N,ServerPID,NumberOfZeroes)->
  Bitcoin = "pkamble",
  BitcoinKey = Bitcoin ++ integer_to_list(N),

  SHA = binary:decode_unsigned(crypto:hash(sha256, BitcoinKey)),
  SHA_String = io_lib:format("~64.16.0b", [SHA]),

  Subs = substr(SHA_String, 1, NumberOfZeroes),

  ZeroString = "00000000000000000000000000000000000000000000000000000000000",
  ZeroSubs = substr(ZeroString, 1, NumberOfZeroes),

  case Subs of
    ZeroSubs ->
      ServerPID ! {response, BitcoinKey ,SHA_String};
    _Else -> false
  end.

actor_call(RangeL, RangeR, ServerPID, NumberOfZeroes) ->
      Bitcoin = "pkamble:",
      mineCoin(Bitcoin, RangeL, RangeR, NumberOfZeroes, ServerPID),
      actor_call(RangeL, RangeR, ServerPID,NumberOfZeroes).

convert(Pid, Request) ->
  Pid ! {Pid, Request},
  receive
    {} -> {}
  end,
  convert(Pid, Request).

server() ->
  receive
    {response, BitcoinKey, Response} ->
      io:fwrite("Server wala Response Key: ~p     SHA-String: ~p~n", [BitcoinKey, Response]);
    {SID, {zero, NumberOfZeroes}} ->
      spawn(fun() -> actor_call(100000, 200000, SID, NumberOfZeroes) end),
      spawn(fun() -> actor_call(400000, 500000, SID, NumberOfZeroes) end)
  end,
  server().

main() ->
  {ok, [NumberOfZeroes]} = io:fread("input : ", "~d"),
  SID = spawn(fun() -> server() end),
  convert(SID, {zero, NumberOfZeroes}).


