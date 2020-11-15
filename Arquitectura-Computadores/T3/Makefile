CC=gcc
CFLAGS= -g -m32 -std=c99 -Wall -pedantic
LDFLAGS= -g -m32
ASFLAGS= --32


%.s: %.c
	$(CC) -O -m32 -std=c99 -Wall -pedantic -S $<

test-sort-x86: test-sort.o sort-x86.o
	$(CC) $(CFLAGS) test-sort.o sort-x86.o -o test-sort-x86

test-sort-x86-im: test-sort.o sort-x86-im.o
	$(CC) $(CFLAGS) test-sort.o sort-x86-im.o -o test-sort-x86-im

test-sort-c: test-sort.o sort-c.o
	$(CC) $(CFLAGS) test-sort.o sort-c.o -o test-sort-c

test-sort-c-im: test-sort.o sort-c-im.o
	$(CC) $(CFLAGS) test-sort.o sort-c-im.o -o test-sort-c-im

run-sort-x86-im:
	make clean
	make test-sort-x86-im
	./verificar test-sort-x86-im out-x86 out.ref

run-sort-c-im:
	make clean
	make test-sort-c-im
	./verificar test-sort-c-im out-c out.ref

clean:
	rm -f *.o test-sort-x86 test-sort-x86-im test-sort-c test-sort-c-im
	rm -f out-x86 out-c
