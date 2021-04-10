# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem95
#
# Para compilar ingrese make monprodcons
#
# Elegir una entre los siguientes ejemplos
#
# monprodcons monprodcons2
#

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

CFLAGS= -g -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= $(LIBNSYS) -pthread

#CFLAGS= -ggdb -I$(NSYSTEM)/include -I$(NSYSTEM)/src
#LDFLAGS= -g

all: monprodcons monprodcons2

monprodcons: $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h $(LIBNSYS)

monprodcons2: $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h $(LIBNSYS)

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ monprodcons monprodcons2
