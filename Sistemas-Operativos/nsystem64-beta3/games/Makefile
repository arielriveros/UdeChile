# Para usar este Makefile es necesario definir la variable
# de ambiente NSYSTEM con el directorio en donde se encuentra
# la raiz de nSystem.  En csh esto se hace con:
#
#   export NSYSTEM=.../nsystem64-beta3
#
# Para compilar ingrese make <ejemplo>
#
# Ej 1: make pong
# Ej 2: make game
# Ej 3: make ball
#
# No hay mas por ahora
#
# Para Linux/amd64:
# instale previamente como root: apt-get install libncurses5-dev
# y luego use estos flags (curses estandar tiene bugs en linux):
#

CFLAGS= -g -Wall -pedantic -I$(NSYSTEM)/include -DNODELAY
LDFLAGS= -g
LDLIBS= $(LIBNSYS) -lncurses -ltermcap -lm -pthread

#
# CFLAGS= -O2 -I$(NSYSTEM)/include -I/usr/include/ncurses -DNCURSES -DNODELAY
# LFLAGS=
# LIBS= $(LIBNSYS) -lncurses -lm

# Para Linux/x86
# instale previamente como root: apt-get install libncurses-dev
# y luego use estos flags (curses estandar tiene bugs en linux):
#
#CFLAGS= -g -m32 -Wall -pedantic -I$(NSYSTEM)/include -DNODELAY
#LDFLAGS= -g -m32
#LDLIBS= $(LIBNSYS) -lncurses -ltermcap -lm -pthread

# Si no funciona, pruebe con:
# LIBS= $(LIBNSYS) -lncurses -ltermcap -lm
# En mi Suse 6.2 habia que poner -ltermcap
# En Suse 7.2 no existe -ltermcap
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

all: pong game ball ball1

pong: pong.o tty.o $(LIBNSYS)

ball: ball.o tty.o $(LIBNSYS)

ball1: ball1.o tty.o $(LIBNSYS)

game: game.o ladder.o tty.o $(LIBNSYS)

pong.o ball.o ball1.o game.o ladder.o tty.o: $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

clean:
	rm -f *.o *~

cleanall:
	rm -f *.o *~ game pong ball ball1
