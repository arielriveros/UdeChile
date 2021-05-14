#include <nSystem.h>
#include <fifoqueues.h>
#include <string.h>

#include "lrlock.h"

typedef struct {
  nMonitor m;
  FifoQueue q;
  int verbose;
  int busy[2];
  int tick;
  int r;
} *Ctrl;

static Ctrl makeCtrl(int verbose, int tick, int r) {
  Ctrl ctl= malloc(sizeof(*ctl));
  ctl->m= nMakeMonitor();
  ctl->q= MakeFifoQueue();
  ctl->verbose= verbose;
  ctl->busy[0]= ctl->busy[1]= FALSE;
  ctl->tick= tick;
  ctl->r= r;
  return ctl;
}

static void addToken(Ctrl ctl, char *token) {
  nEnter(ctl->m);
  PutObj(ctl->q, token);
  nExit(ctl->m);
}

static void check(Ctrl ctl, char *ref) {
  nEnter(ctl->m);
  char *token= GetObj(ctl->q);
  nExit(ctl->m);
  if (token==NULL || strcmp(token, ref)!=0) {
    nFatalError("check", "%s debio ser %s\n", token, ref);
  }
}

#if 0
static void verify(int bool, char *failmsg) {
  if (!bool) {
    nFatalError("verify", "%s\n", failmsg);
  }
}
#endif

static int HalfClient(Ctrl ctl, char *token, int w) {
  for (int i= 0; i<ctl->r; i++) {
    if (ctl->verbose)
      nPrintf("halfLock de %s solicitado\n", token);
    int side= halfLock();
    if (ctl->busy[side])
      nFatalError("HalfClient", "Lado %s ya fue otorgado\n", side);
    ctl->busy[side]= TRUE;
    if (ctl->verbose)
      nPrintf("halfLock de %s otorgado\n", token);
    addToken(ctl, token);
    nSleep(w*ctl->tick);
    if (ctl->verbose)
      nPrintf("halfUnLock de %s\n", token);
    ctl->busy[side]= FALSE;
    halfUnlock(side);
  }
  return 0;
}

static int FullClient(Ctrl ctl, char *token, int w) {
  for (int i= 0; i<ctl->r; i++) {
    if (ctl->verbose)
      nPrintf("fullLock de %s solicitado\n", token);
    fullLock();
    if (ctl->busy[0] || ctl->busy[1])
      nFatalError("FullClient", "Al menos un lado ya fue otorgado\n");
    ctl->busy[0]= ctl->busy[1]= TRUE;
    if (ctl->verbose)
      nPrintf("fullLock de %s otorgado\n", token);
    addToken(ctl, token);
    nSleep(w*ctl->tick);
    if (ctl->verbose)
      nPrintf("fullUnLock de %s\n", token);
    ctl->busy[0]= ctl->busy[1]= FALSE;
    fullUnlock();
  }
  return 0;
}

int simpleTest(int verbose, int tick) {
  Ctrl ctl= makeCtrl(verbose, tick, 1);

  if (verbose)
    nPrintf("Test: Un solo halfLock\n");

  {
    nTask t= nEmitTask(HalfClient, ctl, "half", 2);
    nSleep(tick);
    check(ctl, "half");
    nWaitTask(t);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: Un solo fullLock\n");

  {
    nTask t= nEmitTask(FullClient, ctl, "full", 3);
    nSleep(tick);
    check(ctl, "full");
    nWaitTask(t);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 halfLock deben ingresar en paralelo\n");

  {
    nTask t1= nEmitTask(HalfClient, ctl, "half1", 3);
    nSleep(tick);
    check(ctl, "half1");
    nTask t2= nEmitTask(HalfClient, ctl, "half2", 2);
    nSleep(tick);
    check(ctl, "half2");
    nWaitTask(t1);
    nWaitTask(t2);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 fullLock deben ingresar secuencialmente\n");

  {
    nTask t1= nEmitTask(FullClient, ctl, "full1", 3);
    nSleep(tick);
    check(ctl, "full1");
    nTask t2= nEmitTask(FullClient, ctl, "full2", 2);
    nSleep(3*tick);
    check(ctl, "full2");
    nWaitTask(t1);
    nWaitTask(t2);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: fullLock seguido de halfLock "
            "deben ingresar secuencialmente\n");

  {
    nTask t1= nEmitTask(FullClient, ctl, "full", 3);
    nSleep(tick);
    check(ctl, "full");
    nTask t2= nEmitTask(HalfClient, ctl, "half", 2);
    nSleep(3*tick);
    check(ctl, "half");
    nWaitTask(t1);
    nWaitTask(t2);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: halfLock seguido de fullLock "
            "deben ingresar secuencialmente\n");

  {
    nTask t1= nEmitTask(HalfClient, ctl, "half", 3);
    nSleep(tick);
    check(ctl, "half");
    nTask t2= nEmitTask(FullClient, ctl, "full", 2);
    nSleep(3*tick);
    check(ctl, "full");
    nWaitTask(t1);
    nWaitTask(t2);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 halfLock seguidos de 1 fullLock\n"
            "los primeros deben ingresar en paralelo, luego fullLock\n");

  {
    nTask t1= nEmitTask(HalfClient, ctl, "half1", 3);
    nSleep(tick);
    check(ctl, "half1");
    nTask t2= nEmitTask(HalfClient, ctl, "half2", 5);
    nSleep(tick);
    check(ctl, "half2");
    nTask t3= nEmitTask(FullClient, ctl, "full", 2);
    nSleep(5*tick);
    check(ctl, "full");
    nWaitTask(t1);
    nWaitTask(t2);
    nWaitTask(t3);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: ha(3) hb fa hc(3) hd he hf(2) hg fb fc hh hi(2) fd hj hk fe");

  {
    nTask ha= nEmitTask(HalfClient, ctl, "ha", 2);
    nSleep(tick);
    nTask hb= nEmitTask(HalfClient, ctl, "hb", 1);
    nSleep(tick);
    nTask fa= nEmitTask(FullClient, ctl, "fa", 1);
    nSleep(tick);
    nTask hc= nEmitTask(HalfClient, ctl, "hc", 3);
    nSleep(tick);
    nTask hd= nEmitTask(HalfClient, ctl, "hd", 1);
    nSleep(tick);
    nTask he= nEmitTask(HalfClient, ctl, "he", 1);
    nSleep(tick);
    nTask hf= nEmitTask(HalfClient, ctl, "hf", 2);
    nSleep(tick);
    nTask hg= nEmitTask(HalfClient, ctl, "hg", 1);
    nSleep(tick);
    nTask fb= nEmitTask(FullClient, ctl, "fb", 1);
    nSleep(tick);
    nTask fc= nEmitTask(FullClient, ctl, "fc", 1);
    nSleep(tick);
    nTask hh= nEmitTask(HalfClient, ctl, "hh", 1);
    nSleep(tick);
    nTask hi= nEmitTask(HalfClient, ctl, "hi", 2);
    nSleep(tick);
    nTask fd= nEmitTask(FullClient, ctl, "fd", 1);
    nSleep(tick);
    nTask hj= nEmitTask(HalfClient, ctl, "hj", 1);
    nSleep(tick);
    nTask hk= nEmitTask(HalfClient, ctl, "hk", 1);
    nSleep(tick);
    nTask fe= nEmitTask(FullClient, ctl, "fe", 1);
    while (!EmptyFifoQueue(ctl->q))
      (void)GetObj(ctl->q);
    nWaitTask(ha);
    nWaitTask(hb);
    nWaitTask(hc);
    nWaitTask(hd);
    nWaitTask(he);
    nWaitTask(hf);
    nWaitTask(hg);
    nWaitTask(hh);
    nWaitTask(hi);
    nWaitTask(hj);
    nWaitTask(hk);
    nWaitTask(fa);
    nWaitTask(fb);
    nWaitTask(fc);
    nWaitTask(fd);
    nWaitTask(fe);
    if (verbose) nPrintf("Aprobado\n");
  }
  return 0;
}

int robustez(int m, int r) {
  Ctrl ctl= makeCtrl(FALSE, 0, r);
  nTask htasks[m], ftasks[m];
  for (int i= 0; i<m; i++) {
    htasks[i]= nEmitTask(HalfClient, ctl, "half", 0);
    ftasks[i]= nEmitTask(FullClient, ctl, "full", 0);
   }
  for (int i= 0; i<m; i++) {
    nWaitTask(htasks[i]);
    nWaitTask(ftasks[i]);
  }
  return 0;
}

int nMain() {
  init();
  simpleTest(TRUE, 200);

  nPrintf("\n");
  nPrintf("---------------------------------------\n");
  nPrintf("Test de robustez en modo non preemptive\n");
  nPrintf("---------------------------------------\n\n");


  nSetTimeSlice(1);

  {
    int n= 10, m= 50, r= 200;
    nPrintf("%d left/right locks, c/u con %d threads que llaman %d veces\n",
            n, m, r);
    nPrintf("a halfLock y %d threads que llaman %d veces fullLock\n",
            m, r);
    nSleep(1000);
    int ini= nGetTime();
    nTask tasks[n];
    for (int i= 0; i<n; i++) {
      tasks[i]= nEmitTask(robustez, m, r);
    }
    for (int i= 0; i<n; i++) {
      nWaitTask(tasks[i]);
    }
    int time= nGetTime()-ini;
    nPrintf("El test tomo %d milisegundos\n", time);
    nPrintf("Aprobado\n");
  }
  
  nPrintf("Felicitaciones: aprobo todos los tests\n");

  return 0;
}
