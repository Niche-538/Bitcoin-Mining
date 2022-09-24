% Server mine coins and when client is available asks client to mine too. Distribute work to clients who ask for work
% All coins are displayed on server

-module(server).
-import(string, [substr/3, equal/2]).
-import(client, [actor_call/0]).
-export([main/0]).

server(Pid, Request) ->
  Pid ! {Pid, Request},
  receive
    {response, BitcoinKey, Response} ->
      io:fwrite("Output ~p ~p~n", [ BitcoinKey, Response])
  end,
  server(Pid, Request).

serverFunctions() ->
  receive
    {SID, {zero, NumberOfZeroes}} ->
      server(spawn(fun() -> actor_call() end), {values ,100000, 200000, SID, NumberOfZeroes}),
      server(spawn(fun() -> actor_call() end), {values ,200000, 300000, SID, NumberOfZeroes}),
      server(spawn(fun() -> actor_call() end), {values ,300000, 400000, SID, NumberOfZeroes}),
      server(spawn(fun() -> actor_call() end), {values ,500000, 600000, SID, NumberOfZeroes}),
      server(spawn(fun() -> actor_call() end), {values ,700000, 800000, SID, NumberOfZeroes})
  end,
  serverFunctions().

main() ->
  {ok, [NumberOfZeroes]} = io:fread("input : ", "~d"),
  SID = spawn(fun() -> serverFunctions() end),
  server(SID, {zero, NumberOfZeroes}).


