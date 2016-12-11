SHELL = /bin/sh

APPNAME ?= detach

BIN_FILE ?= $(APPNAME)
MAN_PAGE ?= $(APPNAME).1
BASH_COMPLETION_SCRIPT ?= completion/bash/$(APPNAME).sh

ROOT ?= /usr/local
BIN_DIR ?= $(ROOT)/bin
MAN_DIR ?= $(ROOT)/share/man/man1
BASH_COMPLETION_DIR ?= /etc/bash_completion.d

all : $(BIN_FILE)

clean :
	rm --force -- '$(BIN_FILE)'

install : install-bin install-man install-bash-completion

install-bin : $(BIN_FILE)
	[ -d '$(BIN_DIR)' ] || mkdir --parents '$(BIN_DIR)'
	install -s '$(BIN_FILE)' '$(BIN_DIR)'

install-man : detach.1
	[ -d '$(MAN_DIR)' ] || mkdir --parents '$(MAN_DIR)'
	install -m 644 '$(MAN_PAGE)' '$(MAN_DIR)'
	
install-bash-completion : 
	install -m 644 '$(BASH_COMPLETION_SCRIPT)' '$(BASH_COMPLETION_DIR)/$(APPNAME)'
	
uninstall :
	rm --force -- '$(BASH_COMPLETION_DIR)/$(APPNAME)'
	rm --force -- '$(MAN_DIR)/man1/$(MAN_PAGE)'
	rm --force -- '$(BIN_DIR)/$(BIN_FILE)'
