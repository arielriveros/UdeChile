NSYSTEM=nsystem64-beta3
LIBNSYS= $(NSYSTEM)/lib/libnSys.a

# Con opciones de debugging
CFLAGS= -Wall -pedantic -std=c99 -g -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= $(LIBNSYS)

all: debug

test-lrlock: test-lrlock.o $(LIBNSYS)

test-lrlock.o: $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

debug:
	cd $(NSYSTEM)/src; make
	make test-lrlock

clean:
	cd $(NSYSTEM)/src ; make clean
	rm -f *.o test-lrlock
