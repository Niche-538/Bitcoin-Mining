-module(hello_world).
-compile(export_all).


hello() ->
  io:format("hello world~n").

get_data() ->
  {ok,[N]} = io:fread("Number of zeros : ", "~d"),
  io:format("Number of digits: ~w \n", [N]),
  B = concat("pkamble;" , io:get_line("Bitcoin : ")),
  io:fwrite("~s",[B]),
  io_lib:format("~64.16.0b", [binary:decode_unsigned(crypto:hash(sha256,[B]))]).




