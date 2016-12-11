PREFIX ?= /usr/local

BIN_DIR ?= ${PREFIX}/bin
MAN_DIR ?= ${PREFIX}/share/man
BASH_COMPLETION_DIR ?= /etc/bash_completion.d

TARGETS = detach
OBJECTS = detach

clean :
	-rm -f -- $(OBJECTS)

distclean : clean
	-rm $(TARGETS)

install : install-bin install-man install-bash-completion

install-bin : detach
	[ -d '${BIN_DIR}' ] || mkdir -p '${BIN_DIR}'
	install -s detach '${BIN_DIR}'

install-man : detach.1
	[ -d '${MAN_DIR}/man1' ] || mkdir -p '${MAN_DIR}/man1'
	install -m 644 detach.1 '${MAN_DIR}/man1'
	
install-bash-completion :
	install -m 644 detach.bash_completion.sh '${BASH_COMPLETION_DIR}/detach'
	
uninstall :
	rm -f -- '${BASH_COMPLETION_DIR}/detach'
	rm -f -- '${MAN_DIR}/man1/detach.1'
	rm -f -- '${BIN_DIR}/detach'
