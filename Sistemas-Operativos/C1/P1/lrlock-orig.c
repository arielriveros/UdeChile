#include <nSystem.h>
#include "lrlock.h"

static int busy[2]= { FALSE, FALSE }; // ambas mitades libres
static nSem m; // = nMakeSem(1); parte con 1 ticket

void init() {
  m= nMakeSem(1);
}

int halfLock() {
  if (!busy[LEFT] &&
      !busy[RIGHT])
    nWaitSem(m);
  int L= -1;
  while (L==-1) {
    if (!busy[LEFT])
      L= LEFT;
    else if (!busy[RIGHT])
      L= RIGHT;
  } // ¡busy waiting!
  busy[L]= TRUE;
  return L;
}

void halfUnlock(int L) {
  busy[L]= FALSE;
  if (!busy[LEFT] &&
      !busy[RIGHT])
    nSignalSem(m);
}

void fullLock() {
  nWaitSem(m);
}

void fullUnlock() {
  nSignalSem(m);
}
