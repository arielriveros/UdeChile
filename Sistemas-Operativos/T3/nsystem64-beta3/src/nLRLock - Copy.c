#include "nSystem.h"
#include "fifoqueues.h"
#include "nSysimp.h"

#define FULL_LOCK 2
#define NO_LOCK 3

// Esta es una solucion guiada.  Hagale caso a las indicaciones dadas.

// Use esta representacion de un left/right lock
struct lrlock {
  FifoQueue q; // Cola de tareas en espera.  Debe retomar las tareas
               // en el mismo orden en que aparecen en q.
  int busy[2]; // busy[LEFT] es verdadero si la mitaz izquierda esta ocupada
               // busy[RIGHT] es verdadero si la mitaz derecha esta ocupada
};
nLRLock nMakeLeftRightLock() {
  nLRLock l= nMalloc(sizeof(*l));
  l->q = MakeFifoQueue();
  l->busy[LEFT] = l->busy[RIGHT] = FALSE;
  return l;
}

int nHalfLock(nLRLock l) {
  START_CRITICAL();
  if((l->busy[LEFT] && l->busy[RIGHT]) || !(PeekObj(l->q) == NULL)){
    current_task->status = WAIT_HALF;
    PutObj(l->q, current_task);
    ResumeNextReadyTask();
  }else if(!(l->busy[LEFT])){
      l->busy[LEFT] = TRUE;
      current_task->side = LEFT;
  }
  else{
      l->busy[RIGHT] = TRUE;
      current_task->side = RIGHT;
  }
  END_CRITICAL();
  return current_task->side;
}

void nHalfUnlock(nLRLock l, int side) {
  START_CRITICAL();
  if(current_task->side == LEFT || current_task->side == RIGHT){
    current_task->side = NO_LOCK; // No ambos
  }else{
    current_task->side = !side;
  }
  nTask w= PeekObj(l->q); // Obtiene la primera tarea sin extraerla
  l->busy[side] = FALSE;
  if(w != NULL){
    if(w->status == WAIT_HALF){
      w=GetObj(l->q);
      l->busy[side] = TRUE;
      w->side = side;
      w->status = READY;
      PushTask(ready_queue, current_task);
      PushTask(ready_queue, w);
      ResumeNextReadyTask();
    }else if(w->status == WAIT_FULL){
      if(!(l->busy[!side])){
        w=GetObj(l->q);
        l->busy[LEFT] = l->busy[RIGHT] = TRUE;
        w->side = FULL_LOCK;
        w->status = READY;
        PushTask(ready_queue, current_task);
        PushTask(ready_queue, w);
        ResumeNextReadyTask();
      }
    }
  }  
  END_CRITICAL();
}
 
int nFullLock(nLRLock l, int timeout) {
  START_CRITICAL();
  if(l->busy[LEFT] || l->busy[RIGHT] || !(EmptyFifoQueue(l->q))){
    current_task->status = WAIT_FULL;
    PutObj(l->q, current_task);
    ResumeNextReadyTask();
  }else{
    l->busy[LEFT] = l->busy[RIGHT] = TRUE;
    current_task->side = FULL_LOCK; // Ambos 
  }
  END_CRITICAL();
  return TRUE;
}

void nFullUnlock(nLRLock l) {
  // Si l->q no esta vacia debera retomar si o si la primera tarea en l->q.
  // Extraigala con:
  START_CRITICAL();
  current_task->side = NO_LOCK;
  l->busy[LEFT] = l->busy[RIGHT] = FALSE;
  if(!EmptyFifoQueue(l->q)){
    nTask w= GetObj(l->q);
    if(w->status==WAIT_FULL){
      l->busy[LEFT] = l->busy[RIGHT] = TRUE;
      w->side = FULL_LOCK;
      w->status = READY;
      PushTask(ready_queue, current_task);
      PushTask(ready_queue, w);
      ResumeNextReadyTask();
    }else{
      l->busy[LEFT] = TRUE;
      w->side = LEFT;
      w->status = READY;
      PushTask(ready_queue, current_task);
      nTask w2 = PeekObj(l->q);
      if(w2!= NULL){
        if(w2->status == WAIT_HALF){
          w2 = GetObj(l->q);
          l->busy[RIGHT] = TRUE;
          w2->side = RIGHT;
          w2->status = READY;
          PushTask(ready_queue, w2);
        }
      }
      PushTask(ready_queue, w);
      ResumeNextReadyTask();
    }
  }
  // Considere separadamente los casos:
  // w==NULL (trivial)
  // w->status es WAIT_FULL (simple)
  // w->status es WAIT_HALF: este caso es complicado.
  //   Debe retomar w, pero si el estado de la siguiente tarea en l->q 
  //   tambien es WAIT_HALF, debera retomarla tambien.
  //   Justamente en este caso es donde es importante hacer la asignacion
  //   del lado otorgado aca mismo.  Si comete el error de asignar el lado
  //   en nHalfLock retomara primero w sin que se haya asignado todavia
  //   el lado a la siguiente tarea en l->q.  Mientras ejecuta w pueden
  //   ocurrir cambios de contexto que lleven a ejecutar nHalfLock en
  //   otro thread y encontrar que hay una mitad desocupada, cuando no
  //   es cierto.  Esto lo llevara a resultados incorrectos o en el mejor
  //   de los casos que no se respete el orden de llegada.
  END_CRITICAL();
}
 
void nDestroyLeftRightLock(nLRLock l) {
  DestroyFifoQueue(l->q);
  nFree(l);
}
