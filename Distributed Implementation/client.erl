% Asks server for work on server's ip address and mine coins
-module(client).
-import(string, [substr/3, equal/2]).
-export([actor_call/0]).
-compile(export_all).

actor_call() ->
  receive
    {AID, {values, RangeL, RangeR, ServerPID, NumberOfZeroes}} ->
      Bitcoin = "pkamble:",
      mineCoin(Bitcoin, RangeL, RangeR, NumberOfZeroes, ServerPID, AID)
  end,
  actor_call().


mineCoin(Bitcoin, N, Term, NumberOfZeroes, ServerPID, ActorPID) ->

  case N < Term  of
    true->
      findHash(N,ServerPID, NumberOfZeroes),
      mineCoin(Bitcoin, N + 1, Term, NumberOfZeroes,ServerPID,ActorPID);
    false -> done
  end.

findHash(N,ServerPID, NumberOfZeroes)->
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




