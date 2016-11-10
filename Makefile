PREFIX ?= /usr/local
bindir ?= ${PREFIX}/bin
mandir ?= ${PREFIX}/share/man

TARGETS = detach
OBJECTS =

all : $(TARGETS)

clean :
	#-rm $(OBJECTS)

distclean : clean
	-rm $(TARGETS)

install : install-bin install-man

install-bin : detach
	[ -d '${bindir}' ] || mkdir -p '${bindir}'
	install -s detach '${bindir}'

install-man : detach.1
	[ -d '${mandir}/man1' ] || mkdir -p '${mandir}/man1'
	install -m 644 detach.1 '${mandir}/man1'

love :
	#unzip; strip; touch; finger; mount; fsck; more; yes; umount; sleep

.PHONY : all clean distclean install install-bin install-man love
