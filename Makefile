TARGETS = $(patsubst _%,.%,$(wildcard _*))
all: install

install: $(TARGETS)

$(TARGETS): .% : _%
	@( TARGET_LINK="$(HOME)/$@"; \
	   if [ -f "$${TARGET_LINK}" ]; then \
		rm "$${TARGET_LINK}"; \
	   fi; \
	   if [ -d "$${TARGET_LINK}" ]; then \
		rm -rf "$${TARGET_LINK}"; \
	   fi; \
	   if [ ! -L "$${TARGET_LINK}" ]; then \
		echo Installing $< as $${TARGET_LINK}; \
		ln -s "$(HOME)/bdwconfig/$<" "$${TARGET_LINK}"; \
	   fi)
