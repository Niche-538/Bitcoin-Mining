-module(echo).
-export([start/0]).

loop() -> receive
            {Sender, Num} ->
              Sender ! Num,
              loop()
          end.

start() -> spawn(fun loop/0).