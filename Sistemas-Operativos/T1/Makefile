# Descargue el nSystem desde:
# https://users.dcc.uchile.cl/~lmateu/CC4302/download/nsystem64-beta2.tgz
# Ud. debe descomprimir este archivo con:
# $ tar zxvf nsystem64-beta2.tgz
# Compile el nSystem con:
# $ cd nsystem64-beta2/src
# $ make

# Importante:
# Para compilar exitosamente su tarea necesita definir la variable de
# ambiente NSYSTEM con:
# $ export NSYSTEM=.../nsystem64-beta2
# (debe reemplazar ... por la ruta para llegar a nsystem64-beta2)

# Programe su tarea en el archivo pub.c y luego pruebela con:
# $ cd <el directorio en donde se encuentra este archivo>
# $ make test-pub
# $ ./test-pub
#
# Las siguientes son otras formas de ejecutar su tarea para detectar
# errores de manejo de memoria o dataraces.  Pero *debe* usar pSystem64.
# No intente ejecutar valgrind, drd o sanitize con nSystem64.  Obtendria
# demasiados reportes falso positivos.
#
# make run-valgrind-ddd
# Lanza un proceso para que pueda ser depurado con ddd con el comando de ddd:
# target remote | vgdb --pid ...pid...
# Hay que reemplazar ...pid... por el numero que reporta valgrind con
# ===numero===
# Luego ingresan el comando cont en ddd para lanzar la ejecucion.

# Si valgrind detecta un error de manejo de la memoria la ejecucion se detiene
# justo antes que ocurra y se puede usar ddd para revisar los valores de las
# variables del proceso.
#
# make run-drd-ddd
# Similar a run-valgrind-ddd pero chequea dataraces en vez de errores
# de manejo de memoria.  La ejecucion es extremadamente lenta.
# Es bueno alternar run-valgrind-ddd y run-drd-ddd porque a veces un
# error de manejo de memoria gatilla un datarace y a veces un datarace
# gatilla un error de manejo de memoria.
#

LIBNSYS= $(NSYSTEM)/lib/libnSys.a

# Con opciones de debugging
CFLAGS= -Wall -pedantic -std=c99 -g -I$(NSYSTEM)/include -I$(NSYSTEM)/src
LDFLAGS= -g
LDLIBS= -pthread $(LIBNSYS)

all: debug

test-pub: test-pub.o pub.o $(LIBNSYS)

test-pub.o pub.o: pub.h $(NSYSTEM)/include/nSystem.h $(NSYSTEM)/include/fifoqueues.h

debug:
	make clean
	make test-pub

optimize:
	make clean
	make CFLAGS="-O -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -I$(NSYSTEM)/src" LDFLAGS="" test-pub

run-valgrind-ddd:
	make clean
	make CFLAGS="-g -DVALGRIND=1 -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -I$(NSYSTEM)/src" test-pub
	bash -c 'valgrind --leak-check=full --vgdb=yes --vgdb-error=0 ./test-pub |& tee run.log'

run-drd-ddd:
	make clean
	make CFLAGS="-g -DVALGRIND=1 -Wall -pedantic -std=c99 -I$(NSYSTEM)/include -I$(NSYSTEM)/src" test-pub
	bash -c 'valgrind --tool=drd --vgdb=yes --vgdb-error=0 ./test-pub |& tee run.log'

clean:
	rm -f *.o test-pub
