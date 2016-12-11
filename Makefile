PREFIX ?= /usr/local

bindir ?= ${PREFIX}/bin
mandir ?= ${PREFIX}/share/man
bash_completion_dir ?= /etc/bash_completion.d

TARGETS = detach
OBJECTS = detach

clean :
	-rm -f -- $(OBJECTS)

distclean : clean
	-rm $(TARGETS)

install : install-bin install-man install-bash-completion

install-bin : detach
	[ -d '${bindir}' ] || mkdir -p '${bindir}'
	install -s detach '${bindir}'

install-man : detach.1
	[ -d '${mandir}/man1' ] || mkdir -p '${mandir}/man1'
	install -m 644 detach.1 '${mandir}/man1'
	
install-bash-completion :
	install -m 644 detach.bash_completion.sh '${bash_completion_dir}/detach'
	
uninstall :
	rm -f -- '${bash_completion_dir}/detach'
	rm -f -- '${mandir}/man1/detach.1'
	rm -f -- '${bindir}/detach'
