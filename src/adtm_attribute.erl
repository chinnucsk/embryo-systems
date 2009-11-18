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

-module(adtm_attribute).
-behavior(gen_server).
-author('Nicolas R Dufour <nrdufour@gmail.com>').

-include("adt.hrl").

%% API exports
-export([create/2, create/3, hibern/2, awake/2, destroy/2, resur/2, purge/2, start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

create(ClassName, AttributeName) ->
	gen_server:call(?MODULE, {create, ClassName, AttributeName}).

create(ClassName, AttributeName, Extra) ->
	gen_server:call(?MODULE, {create, ClassName, AttributeName, Extra}).

hibern(ClassName, AttributeName) ->
	gen_server:call(?MODULE, {hadr, hibern, ClassName, AttributeName}).

awake(ClassName, AttributeName) ->
	gen_server:call(?MODULE, {hadr, awake, ClassName, AttributeName}).

destroy(ClassName, AttributeName) ->
	gen_server:call(?MODULE, {hadr, destroy, ClassName, AttributeName}).

resur(ClassName, AttributeName) ->
	gen_server:call(?MODULE, {hadr, resur, ClassName, AttributeName}).

purge(ClassName, AttributeName) ->
	gen_server:call(?MODULE, {purge, ClassName, AttributeName}).

init([]) ->
	process_flag(trap_exit, true),
	io:format("~p starting~n", [?MODULE]),
	{ok, []}.

handle_call(_, _From, State) ->
	{reply, not_yet_implemented, State}.

handle_cast(_Msg, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) ->
	io:format("~p stopping~n", [?MODULE]),
	ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

%% internal API ==============================================================
