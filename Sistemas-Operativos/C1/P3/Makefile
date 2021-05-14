# Programe su solucion en el archivo nBuf.c en este mismo directorio.
# No lo coloque en $(NSYSTEM)/src.
# No necesita definir la variable NSYSTEM.  Esta carpeta ya incluye
#                                           nsystem64-beta3.
# Base su solucion en nBuf.c.plantilla.
# Compile con: make
# Ejecute con: make run    o    ./test-nBuf
# Depure con: ddd test-nBuf
# No tiene sentido correr valgrind o drd.  Reporta errores que no lo son.

NSYSTEM=nsystem64-beta3

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

# Con opciones de debugging
CFLAGS= -Wall -pedantic -std=c99 -g -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= $(LIBNSYS)

all: test-nBuf

test-nBuf: test-nBuf.o nBuf.o $(LIBNSYS)

$(LIBNSYS):
	cd $(NSYSTEM)/src ; make

test-nBuf.o nBuf.o: buf.h $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

run: test-nBuf
	./test-nBuf

clean:
	rm -f *.o test-nBuf
	cd $(NSYSTEM)/src; make clean
	rm -f $(LIBNSYS)
