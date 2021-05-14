#include <nSystem.h>

#include "buf.h"

struct buffer {
  void **array;
  int nextempty, nextfull;
  int count, size;
  nMonitor m;
};

Buffer makeBuffer(int size) {
  Buffer buf= nMalloc(sizeof(*buf));
  buf->array= nMalloc(size*sizeof(void*));
  buf->count= buf->nextempty= buf->nextfull= 0;
  buf->size= size;
  buf->m= nMakeMonitor();
  return buf;
}

void destroyBuffer(Buffer buf) {
  nFree(buf->array);
  nFree(buf);
}

void *get(Buffer buf) {
  nEnter(buf->m);
  while (buf->count==0)
    nWait(buf->m);
  void *ptr= buf->array[buf->nextfull];
  buf->nextfull= (buf->nextfull+1)%buf->size;
  buf->count--;
  nNotifyAll(buf->m);
  nExit(buf->m);
  return ptr;
}

void put(Buffer buf, void *ptr) {
  nEnter(buf->m);
  while (buf->count==buf->size)
    nWait(buf->m);
  buf->array[buf->nextempty]= ptr;
  buf->nextempty= (buf->nextempty+1)%buf->size;
  buf->count++;
  nNotifyAll(buf->m);
  nExit(buf->m);
}

