# Copyright 2010 Nicolas R Dufour <nrdufour@gmail.com>
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

all:  deps compile

deps:
	@./rebar get-deps

compile:
	@./rebar compile

clean:
	@./rebar clean

dist: compile
	@rm -rf rel/embryosys
	@./rebar generate

distclean: clean
	@rm -rf rel/embryosys

include install.mk
install: dist
	@mkdir -p $(prefix)
	@cp -R rel/embryosys/* $(prefix)
	@mkdir -p $(data_dir)
	@chown $(user) $(data_dir)
	@touch $(prefix)/var/log/embryosys.log
	@chown $(user) $(prefix)/var/log/embryosys.log

# THE END
