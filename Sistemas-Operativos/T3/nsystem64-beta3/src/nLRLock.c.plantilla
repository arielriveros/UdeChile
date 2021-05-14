#include "nSystem.h"
#include "fifoqueues.h"
#include "nSysimp.h"

// Esta es una solucion guiada.  Hagale caso a las indicaciones dadas.

// Use esta representacion de un left/right lock
struct lrlock {
  FifoQueue q; // Cola de tareas en espera.  Debe retomar las tareas
               // en el mismo orden en que aparecen en q.
  int busy[2]; // busy[LEFT] es verdadero si la mitaz izquierda esta ocupada
               // busy[RIGHT] es verdadero si la mitaz derecha esta ocupada
};

nLRLock nMakeLeftRightLock() {
  nLRLock l= malloc(sizeof(*l));
  ...
  return l;
}

int nHalfLock(nLRLock l) {
  // Agregue los estados WAIT_HALF y WAIT_FULL en nSysimp.h.
  // Si debe esperar cambie el status de current_task a WAIT_HALF.
  // Agregue el campo side al descriptor de tarea en nSysimp.h.
  // Asigne el lado otorgado a current_task->side.
  // Como en las tareas 1 y 2, si debe esperar la asignacion del lado
  // debe hacerse en nHalfUnlock o nFullUnlock.  De otro modo tendra
  // dataraces dificiles de diagnosticar.
  ...
  return current_task->side;
}

void nHalfUnlock(nLRLock l, int side) {
  ...
  // Para determinar si puede retomar la primera tarea en l->q use:

  nTask w= PeekObj(l->q); // Obtiene la primera tarea sin extraerla

  // Considere separadamente los casos en que:
  // w es NULL
  // w->status es WAIT_HALF (debera retomar esta tarea si o si)
  // w->status es WAIT_FULL (puede retomar esta tarea solo si la otra mitad
  //   de l tambien esta desocupada)
  ...
}
 
int nFullLock(nLRLock l, int timeout) {
  // Recuerde: en esta tarea timeout es siempre -1.
  // Si debe esperar cambie el status de current_task a WAIT_FULL.
  ...
  return TRUE;
}

void nFullUnlock(nLRLock l) {
  // Si l->q no esta vacia debera retomar si o si la primera tarea en l->q.
  // Extraigala con:

  nTask w= GetObj(l->q);

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
}
 
void nDestroyLeftRightLock(nLRLock l) {
  ...
}
