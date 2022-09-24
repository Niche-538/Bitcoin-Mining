-module(master).
% -import(server, [actor_call/4]).
% -export([main/0]).

% convert(Pid, Request) ->
%     Pid ! {Pid, Request},
%     receive
%         {} -> {}
%     end,
%     convert(Pid, Request).

% server() ->
%     receive
%         {response, BitcoinKey, Response} ->
%             io:fwrite("Server wala Response Key: ~p     SHA-String: ~p~n", [BitcoinKey, Response]);
%         {SID, {zero, NumberOfZeroes}} ->
%             spawn(fun() -> actor_call(100000, 200000, SID, NumberOfZeroes) end),
%             spawn(fun() -> actor_call(400000, 500000, SID, NumberOfZeroes) end)
%     end,
%     server().

% main() ->
%     {ok, [NumberOfZeroes]} = io:fread("input : ", "~d"),
%     SID = spawn(fun() -> server() end),
%     convert(SID, {zero, NumberOfZeroes}).
