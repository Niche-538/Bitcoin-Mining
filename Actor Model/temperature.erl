-module(temperature).

-compile(export_all).

convert(Pid, Request) ->
  Pid ! {self(), Request},
  receive
    {Pid, Response} -> Response
  end.

temperatureConverter() ->
  receive
    {From, {toF, C}} ->
      From ! {self(), 32+C*9/5},
      temperatureConverter()
  end.

start() ->
  spawn(fun() -> temperatureConverter() end).

