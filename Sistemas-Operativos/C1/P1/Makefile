# Programe su solucion en el archivo lrlock.c en este mismo directorio.
# El contenido actual de lrlock.c es la solucion incorrecta del enunciado.
# Compile con: make
# Ejecute con: make run o ./test-lrlock
# Depure con: ddd test-lrlock
# Valgrind con: make valgrind-ddd
# No tiene sentido correr drd, arroja errores con la solucion correcta

NSYSTEM=../psystem64-alfa4

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

# Con opciones de debugging
CFLAGS= -Wall -pedantic -std=c99 -g -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= -pthread $(LIBNSYS)

all: test-lrlock

test-lrlock: test-lrlock.o lrlock.o $(LIBNSYS)

$(LIBNSYS):
	cd $(NSYSTEM)/src ; make

test-lrlock.o lrlock.o: lrlock.h $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

run: test-lrlock
	./test-lrlock

valgrind-ddd: test-lrlock
	bash -c 'valgrind --vgdb=yes --vgdb-error=0 ./test-lrlock |& tee run.log'
 
clean:
	rm -f *.o test-lrlock *.log
	cd $(NSYSTEM)/src ; make clean
	rm -f $(LIBNSYS)
