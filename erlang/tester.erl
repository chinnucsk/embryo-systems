%%%
%%% Tester module from Joe Amrstrong's book (Programming Erlang)
%%%
-module(tester).
-export([main/1]).

main([A]) ->
	I = list_to_integer(atom_to_list(A)),
	F = fac(I),
	io:format("factorial ~w = ~w~n" ,[I, F]),
	init:stop().

fac(0) -> 1;
fac(N) -> N*fac(N-1).

