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
  if((l->busy[LEFT] && l->busy[RIGHT]) || PeekObj(l->q) != NULL){
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
    current_task->side = NO_LOCK;
  }else{
    current_task->side = !side;
  }
  nTask w = PeekObj(l->q);
  l->busy[side] = FALSE;
  if(w != NULL  && !(l->busy[!side])){
    if(w->status==WAIT_FULL_TIMEOUT || w->status==READY){
        if(!(l->busy[!side])){
          w = GetObj(l->q);
          w->successFullLock = l->busy[LEFT]= l->busy[RIGHT] = TRUE;
          w->side = FULL_LOCK;
          if(w->status==READY){
            PushTask(ready_queue, GetTask(ready_queue));
          }else{
            CancelTask(w);
            w->status = READY;
            PushTask(ready_queue, w);
        }
        PushTask(ready_queue, current_task);
        ResumeNextReadyTask();
      }  
    }else{
      w = GetObj(l->q);
      if(w->status == WAIT_HALF){
        l->busy[side] = TRUE;
        w->side = side;
      }else{
        w->successFullLock = l->busy[LEFT] = l->busy[RIGHT] = TRUE;
        w->side = FULL_LOCK;
      }      
        w->status = READY;
        PushTask(ready_queue, current_task);
        PushTask(ready_queue, w);
        ResumeNextReadyTask();
    }
  }
  END_CRITICAL();
}

int nFullLock(nLRLock l, int timeout) {
  START_CRITICAL();
  current_task->successFullLock = FALSE;
  if(l->busy[LEFT] || l->busy[RIGHT] || PeekObj(l->q) != NULL){
      if(0 <= timeout){
        current_task->status = WAIT_FULL_TIMEOUT;
        ProgramTask(timeout);
      }else{
        current_task->status = WAIT_FULL;
      }
      PutObj(l->q, current_task);
      ResumeNextReadyTask();
  }
  else{
    current_task->successFullLock = l->busy[LEFT] = l->busy[RIGHT] = TRUE;
    current_task->side= FULL_LOCK;
  }
  if(current_task->successFullLock == FALSE){
    DeleteObj(l->q, current_task);
  }
  END_CRITICAL();
  return current_task->successFullLock;
}

void nFullUnlock(nLRLock l) {
  START_CRITICAL();
  current_task->side= NO_LOCK;
  l->busy[LEFT] = l->busy[RIGHT] = FALSE;
  if(PeekObj(l->q) != NULL){
    nTask w = GetObj(l->q);
    if(w->status == WAIT_FULL){
      w->successFullLock = l->busy[LEFT] = l->busy[RIGHT] = TRUE;
      w->side = FULL_LOCK;
      w->status = READY;
      PushTask(ready_queue, current_task);
      PushTask(ready_queue, w);
      ResumeNextReadyTask();
    }
    else if(w->status==WAIT_FULL_TIMEOUT || w->status==READY){
      w->successFullLock = l->busy[LEFT] = l->busy[RIGHT] = TRUE;
      w->side = FULL_LOCK;
      if(w->status==READY){
        PushTask(ready_queue, GetTask(ready_queue));
      }else{
        CancelTask(w);
        w->status = READY;
        PushTask(ready_queue, w);
      }
      PushTask(ready_queue, current_task);
      ResumeNextReadyTask();
    }else{
      l->busy[LEFT]=TRUE;
      w->side=LEFT;
      w->status= READY;
      PushTask(ready_queue, current_task);
      nTask nextTask = PeekObj(l->q);
      if(nextTask!=NULL){
        if(nextTask->status==WAIT_HALF){
          nextTask= GetObj(l->q);
          l->busy[RIGHT]=TRUE;
          nextTask->side=RIGHT;
          nextTask->status=READY;
          PushTask(ready_queue,nextTask);
        }
      }
      PushTask(ready_queue,w);
      ResumeNextReadyTask();
    }
  }
  END_CRITICAL();
}
 
void nDestroyLeftRightLock(nLRLock l) {
  DestroyFifoQueue(l->q);
  nFree(l);
}