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

%% @record adt_id
-record(adt_id, {
		%% type: family / property / relation / entity (for now).
		type,
		%% address: tuple containing n uuid according to the type.
		%% 	family:   { x }
		%%	property: { x, y }
		%%	relation: { x, y, z }
		%%	entity:   { x, y }
		address
	}).

%% @record adt
-record(adt, {
		%% id: adt_id record
		id,
		%% fname: friendly name.
		fname,
		%% state: alive / frozen / destroyed.
		state

		%% TODO probably need to add more fields here ...
	}).
