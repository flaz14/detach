PREFIX ?= /usr/local
bindir ?= ${PREFIX}/bin
mandir ?= ${PREFIX}/share/man
bash_complete_dir ?= /etc/bash_completion.d

TARGETS = detach
OBJECTS =

all : $(TARGETS)

clean :
	#-rm $(OBJECTS)

distclean : clean
	-rm $(TARGETS)

install : install-bin install-man install-bash-complete

install-bin : detach
	[ -d '${bindir}' ] || mkdir -p '${bindir}'
	install -s detach '${bindir}'

install-man : detach.1
	[ -d '${mandir}/man1' ] || mkdir -p '${mandir}/man1'
	install -m 644 detach.1 '${mandir}/man1'
	
install-bash-complete:
	install -m 644 detach.bash_complete.sh '${bash_complete_dir}/detach'

love :
	#unzip; strip; touch; finger; mount; fsck; more; yes; umount; sleep

.PHONY : all clean distclean install install-bin install-man love
