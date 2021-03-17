# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem97
#
# Para compilar ingrese make iotest
#
# Elegir una entre los siguientes ejemplos
#
# msgprodcons iotest term-serv
#

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

CFLAGS= -g -Wall -pedantic -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= $(LIBNSYS) -lpthread

# Linux x86
#CFLAGS= -g -m32 -I$(NSYSTEM)/include -I$(NSYSTEM)/src
#LDFLAGS= -g -m32 $(LIBNSYS) -lpthread

all: msgprodcons test

msgprodcons: $(LIBNSYS)

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ msgprodcons test
