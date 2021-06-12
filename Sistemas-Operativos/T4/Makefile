NSYSTEM=nsystem64-beta3
LIBNSYS= $(NSYSTEM)/lib/libnSys.a

# Con opciones de debugging
CFLAGS= -Wall -pedantic -std=c99 -g -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= $(LIBNSYS)

all: debug

test-lrlock: test-lrlock.o $(LIBNSYS)

test-lrlock.o: $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

test-timeout.o: $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

test-timeout: test-timeout.o $(LIBNSYS)

debug:
	cd $(NSYSTEM)/src; make
	make test-lrlock test-timeout

optimize:
	cd $(NSYSTEM)/src; make "CFLAGS=-O -Wall -pedantic -std=c99 -I../include $(DEFINES)"
	make "CFLAGS=-O -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -I$(NSYSTEM)/src" test-lrlock test-timeout

clean:
	cd $(NSYSTEM)/src ; make clean
	rm -f *.o *.log test-lrlock test-timeout
