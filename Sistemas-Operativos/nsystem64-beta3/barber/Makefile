# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   setenv NSYSTEM ~cc41b/nSystem96
#
# Para compilar ingrese make
#
# En Linux este ejemplo requiere ncurses. Instalelo en debian con:
#   sudo apt-get install libncurses-dev
#

CFLAGS= -g -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -DCURSES -DNODELAY
#CFLAGS= -g -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -DNCURSES -DNODELAY
#LDFLAGS= -g -static
LDFLAGS= -g
LDLIBS= $(LIBNSYS) -lncurses -ltermcap -lm -lpthread

#LIBS= $(LIBNSYS) -lncurses -lm
# y si no resulta entonces:
#
# Para Solaris use:
# CFLAGS= -ggdb -I$(NSYSTEM)/include -DNODELAY
# LFLAGS= -ggdb
# LIBS= $(LIBNSYS) -lcurses -ltermcap -lm
#
# Para SunOS use:
# CFLAGS= -ggdb -I$(NSYSTEM)/include
# LFLAGS= -ggdb
# LIBS= $(LIBNSYS) -L/usr/5lib -lcurses -ltermcap -lm

#
LIBNSYS= $(NSYSTEM)/lib/libnSys.a

all: fifo

fifo: personajes.o fifo.o tty.o main.o $(LIBNSYS)

personajes.o fifo.o tty.o main.o: barber.h $(LIBNSYS) $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

sanitize:
	make cleanall
	make CFLAGS='-fsanitize=thread -g -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -DCURSES -DNODELAY' LDFLAGS='-g -fsanitize=thread'

run-drd-ddd:
	make cleanall
	make
	bash -c 'valgrind --tool=drd --vgdb=yes --vgdb-error=0 ./fifo |& tee run3.log'

run-valgrind-ddd:
	make cleanall
	make
	bash -c 'valgrind --vgdb=yes --vgdb-error=0 ./fifo |& tee run3.log'

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ fifo
