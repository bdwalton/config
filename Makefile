TARGETS = $(patsubst _%,.%,$(wildcard _*))
all: install

install: $(TARGETS)

$(TARGETS): .% : _%
	@( if [ ! -L "$(HOME)/$@" ]; then \
		echo Installing $< to $(HOME)/$@; \
		ln -s "$(HOME)/bdwconfig/$<" "$(HOME)/$@"; \
	   fi)
