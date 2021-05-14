# Programe su solucion en el archivo buf.c en este mismo directorio
# La solucion actual en el archivo buf.c no respeta orden de llegada.
# Es la de los apuntes.
# Compile con: make
# Ejecute con: make run o ./test-buf
# Valgrind con: make valgrind-ddd
# Drd con: make drd-ddd
# Clean: con make clean

NSYSTEM=../psystem64-alfa4

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

# Con opciones de debugging
CFLAGS= -Wall -pedantic -std=c99 -g -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= -pthread $(LIBNSYS)

all: test-buf

test-buf: test-buf.o buf.o $(LIBNSYS)

$(LIBNSYS):
	cd $(NSYSTEM)/src ; make

test-buf.o buf.o: buf.h $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

run: test-buf
	./test-buf

valgrind-ddd: test-buf
	bash -c 'valgrind --track-origins=yes --vgdb=yes --vgdb-error=0 ./test-buf |& tee run.log'

drd-ddd: test-buf
	bash -c 'valgrind --tool=drd --vgdb=yes --vgdb-error=0 ./test-buf |& tee run.log'
 
clean:
	rm -f *.o test-buf *.log
	cd $(NSYSTEM)/src ; make clean
	rm -f $(LIBNSYS)
