LIBDIR=$(shell erl -eval 'io:format("~s~n", [code:lib_dir()])' -s init stop -noshell)

VERSION=0.0.1

all:
	mkdir -p ebin
	(cd src;$(MAKE))

doc:
	(cd src; $(MAKE) doc)

test: all 
	prove t/*.t

cover: all 
	COVER=1 prove t/*.t
	erl -noshell -eval 'etap_report:create()' -s init stop

clean:
	(cd src;$(MAKE) clean)
	rm -rf cover/

package: clean
	@mkdir embryosys-$(VERSION)/ && cp -rf Makefile README src support t embryosys-$(VERSION)
	@COPYFILE_DISABLE=true tar zcf embryosys-$(VERSION).tgz embryosys-$(VERSION)
	@rm -rf embryosys-$(VERSION)/

install:
	mkdir -p $(prefix)/$(LIBDIR)/embryosys-$(VERSION)/ebin
	for i in ebin/*.beam; do install $$i $(prefix)/$(LIBDIR)/embryosys-$(VERSION)/$$i ; done
