-module(var).
-export([init/0, add/1, get/0]).

init() ->
  Pid = spawn(fun() -> loop(0) end),
  register(variable, Pid).            % we keep track of the process id

loop(N) ->
  receive
    {add, X} -> loop(N+X);          % we accept more than one type of message: the first has the atom add as the first element for identification
    {Parent, get} ->                % in case of get, before restarting the loop we send a message to Parent with the value
      Parent ! N,
      loop(N)
  end.

add(X) ->                       % these primitives can be called from the parent process, like init()
  variable ! {add, X}.

get() ->
  variable ! {self(), get},
  receive Result -> Result end.