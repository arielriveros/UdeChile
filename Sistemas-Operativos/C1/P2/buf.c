#include <nSystem.h>
#include "buf.h"
#include "fifoqueues.h"

struct buffer {
  void **array;
  int nextempty, nextfull, count, size;
  nMonitor m;
  FifoQueue queue;
};

typedef struct  {
  int cond;
  nCondition condicion;
  void *item;  
}Consumidor;

Buffer makeBuffer(int size) {
  Buffer buf= nMalloc(sizeof(*buf));
  buf->array= nMalloc(size*sizeof(void*));
  buf->count= buf->nextempty= buf->nextfull= 0;
  buf->size= size;
  buf->queue= MakeFifoQueue();
  buf->m= nMakeMonitor();
  return buf;
}

void destroyBuffer(Buffer buf) {
  nFree(buf->array);
  nFree(buf);
}

void *get(Buffer buf) {
  nEnter(buf->m);
  Consumidor cons;
  cons.item = NULL;
  cons.condicion =  nMakeCondition(buf->m);
  PutObj(buf->queue, &cons);
  while (buf->count == 0) {
    nWaitCondition(cons.condicion);
    if(cons.item != NULL){
      nSignalCondition(cons.condicion);
      nExit(buf->m);
      return cons.item;
    }
  }
  void *ptr = buf->array[buf->nextfull];
  void *useless = GetObj(buf->queue); // Variable solo para quitar elemento de queue
  buf->nextfull= (buf->nextfull+1)%buf->size;  
  buf->count--;
  nSignalCondition(cons.condicion);
  nExit(buf->m);
  return ptr;
}

void put(Buffer buf, void *ptr) {
  nEnter(buf->m);
  while (buf->count == buf->size) nWaitCondition(buf->count == buf->size);
  if(!EmptyFifoQueue(buf->queue)){
    Consumidor *aux = GetObj(buf->queue);
    aux->item = ptr;
    nSignalCondition(aux->condicion);
    nExit(buf->m);
    return ;
  }
  buf->array[buf->nextempty] = ptr;
  buf->nextempty = (buf->nextempty+1)%buf->size;
  buf->count++;
  nExit(buf->m);
}



