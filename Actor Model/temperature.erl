
-module(temperature).

%% API
-compile(export_all).

temperatureConverter() ->
  receive
    {toF, C} ->
      io:format("~p C is ~p F~n", [C, 32+C*9/5]),
      temperatureConverter();
    {toC, F} ->
      io:format("~p F is ~p C~n", [F, (F-32)*5/9]),
      temperatureConverter();
    {stop} ->
      io:format("Stopping~n");
    Other ->
      io:format("Unknown: ~p~n", [Other]),
      temperatureConverter()
  end.
