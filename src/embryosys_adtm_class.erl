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

-module(embryosys_adtm_class).
-behavior(gen_server).
-author('Nicolas R Dufour <nrdufour@gmail.com>').

-include("adt.hrl").

%% API exports
-export([create/1, hibern/1, awake/1, destroy/1, resur/1, purge/1, start_link/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

create(Name) ->
	gen_server:call(?MODULE, {create, Name}).

hibern(Name) ->
	gen_server:call(?MODULE, {hadr, hibern, Name}).

awake(Name) ->
	gen_server:call(?MODULE, {hadr, awake, Name}).

destroy(Name) ->
	gen_server:call(?MODULE, {hadr, destroy, Name}).

resur(Name) ->
	gen_server:call(?MODULE, {hadr, resur, Name}).

purge(Name) ->
	gen_server:call(?MODULE, {purge, Name}).

init([]) ->
	process_flag(trap_exit, true),
	io:format("~p starting~n", [?MODULE]),
	{ok, []}.

handle_call({create, Name}, _From, State) ->
	{reply, do_create(Name), State};

handle_call({hadr, Operation, Name}, _From, State) ->
	{reply, do_hadr(Operation, Name), State};

handle_call({purge, Name}, _From, State) ->
	{reply, do_purge(Name), State}.

handle_cast(_Msg, State) -> {noreply, State}.

handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) ->
	io:format("~p stopping~n", [?MODULE]),
	ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.

%% internal API ==============================================================

do_create(Name) ->
	case embryosys_storage_server:load(class, Name) of
		not_found ->
			Adt = embryosys_util:new_adt(class, Name),
			AliveAdt = Adt#adt{state = alive},
			embryosys_storage_server:store(class, Name, AliveAdt),
			ok;
		_ ->
			already_created
	end.

do_hadr(Operation, Name) ->
	% first grab the adt from the storage
	Previous = embryosys_storage_server:load(class, Name),
	case Previous of
		not_found ->
			not_found;
		_ ->
			% compute its new state
			NewState = embryosys_util:new_state_after(Operation, Previous#adt.state),
			case NewState of
				wrong_state ->
					wrong_state;
				_ ->
					% and store it
					UpdatedAdt = Previous#adt{state = NewState},
					embryosys_storage_server:store(class, Name, UpdatedAdt),
					ok
			end
	end.

do_purge(_Name) ->
	not_yet_implemented.
