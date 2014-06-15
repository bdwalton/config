CONFIGDIR := "$(CURDIR)"
TARGETS = $(patsubst _%,.%,$(wildcard _*))

all:
	@echo "Run make (install|...)"

install: $(TARGETS)

$(TARGETS): .% : _%
	@( TARGET_LINK="$(HOME)/$@"; \
	   CONFIG_FILE="$(CONFIGDIR)/$<"; \
	   if [ -f "$${TARGET_LINK}" ]; then \
		rm "$${TARGET_LINK}"; \
	   fi; \
	   if [ -d "$${TARGET_LINK}" ]; then \
		rm -rf "$${TARGET_LINK}"; \
	   fi; \
	   echo "Linking '$${TARGET_LINK}' to '$${CONFIG_FILE}'"; \
	   ln -f -s "$(CONFIGDIR)/$<" "$${TARGET_LINK}"; \
         )
