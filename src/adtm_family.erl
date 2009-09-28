%% @author Nicolas R Dufour <nrdufour@gmail.com>
%% @copyright 2009 Nicolas R Dufour.
%%
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(adtm_family).
-author('Nicolas R Dufour <nrdufour@gmail.com>').

-export([execute/2]).

execute(create, Name) ->
	io:format("Create family ~p~n", [Name]),
	Adt = adtm:new(family, Name),
	storage_server:store(family, Name, Adt),
	ok;

execute(hibern, Name) ->
	io:format("Hibern family ~p~n", [Name]),
	Previous = storage_server:load(family, Name),
	Adt = Previous#adt{state = frozen},
	storage_server:store(family, Name, Adt),
	ok;

execute(awake, Name) ->
	io:format("Awake family ~p~n", [Name]),
	Previous = storage_server:load(family, Name),
	Adt = Previous#adt{state = alive},
	storage_server:store(family, Name, Adt),
	ok;

execute(destroy, Name) ->
	io:format("Destroy family ~p~n", [Name]),
	Previous = storage_server:load(family, Name),
	Adt = Previous#adt{state = destroyed},
	storage_server:store(family, Name, Adt),
	ok;

execute(resur, Name) ->
	io:format("Resur family ~p~n", [Name]),
	Adt = adtm:new(family, Name),
	Previous = storage_server:load(family, Name),
	Adt = Previous#adt{state = alive},
	storage_server:store(family, Name, Adt),
	ok;

execute(purge, Name) ->
	io:format("Purge family ~p~n", [Name]),
	ok.

