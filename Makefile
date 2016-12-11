SHELL = /bin/sh

# TODO rename all custom macros to lowercase
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
	rm -f -- '$(BIN_FILE)'

install : install-bin install-man install-bash-completion

install-bin : $(BIN_FILE)
	[ -d '$(BIN_DIR)' ] || mkdir -p '$(BIN_DIR)'
	install -s '$(BIN_FILE)' '$(BIN_DIR)'

install-man : detach.1
	[ -d '$(MAN_DIR)' ] || mkdir -p '$(MAN_DIR)'
	install -m 644 '$(MAN_PAGE)' '$(MAN_DIR)'
	
install-bash-completion : 
	install -m 644 '$(BASH_COMPLETION_SCRIPT)' '$(BASH_COMPLETION_DIR)/$(APPNAME)'
	
uninstall :
	rm -f -- '$(BASH_COMPLETION_DIR)/$(APPNAME)'
	rm -f -- '$(MAN_DIR)/man1/$(MAN_PAGE)'
	rm -f -- '$(BIN_DIR)/$(BIN_FILE)'
