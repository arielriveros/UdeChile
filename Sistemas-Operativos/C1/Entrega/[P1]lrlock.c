#include <nSystem.h>
#include "lrlock.h"

static int busy[2]= { FALSE, FALSE }; // ambas mitades libres
static nSem monitor[3];
void init() {
  monitor[0] = nMakeSem(1); // m
  monitor[1] = nMakeSem(1); // exclusion mutua
  monitor[2] = nMakeSem(2); // analizar si L y R estan en uso
}
int halfLock() {
  nWaitSem(monitor[1]);
  if (!(busy[LEFT] || busy[RIGHT])) nWaitSem(monitor[0]);
  int L= -1;
  nWaitSem(monitor[2]);
  if (!busy[LEFT]) L= LEFT;
  else if (!busy[RIGHT]) L= RIGHT;
  // ¡busy waiting!
  busy[L]= TRUE;
  nSignalSem(monitor[1]);
  return L;
}

void halfUnlock(int L) {
  nWaitSem(monitor[1]);
  busy[L]= FALSE;
  if (!(busy[LEFT] || busy[RIGHT])) nSignalSem(monitor[0]);
  nSignalSem(monitor[1]);
  nSignalSem(monitor[2]);
}
void fullLock() {
  nWaitSem(monitor[0]);
}
void fullUnlock() {
  nSignalSem(monitor[0]);
}
