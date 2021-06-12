#define _DEFAULT_SOURCE
#include <nSystem.h>
#include <fifoqueues.h>
#include <string.h>
#include <stdlib.h>

typedef struct {
  nMonitor m;
  FifoQueue q;
  int verbose;
  nLRLock l;
  int busy[2];
  int tick;
  int r;
} *Ctrl;

static Ctrl makeCtrl(int verbose, int tick, int r) {
  Ctrl ctl= malloc(sizeof(*ctl));
  ctl->m= nMakeMonitor();
  ctl->q= MakeFifoQueue();
  ctl->verbose= verbose;
  ctl->l= nMakeLeftRightLock();
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

static void verify(int bool, char *failmsg) {
  if (!bool) {
    nFatalError("verify", "%s\n", failmsg);
  }
}

static int HalfClient(Ctrl ctl, char *token, int w) {
  for (int i= 0; i<ctl->r; i++) {
    if (ctl->verbose)
      nPrintf("nHalfLock de %s solicitado\n", token);
    int side= nHalfLock(ctl->l);
    if (ctl->busy[side])
      nFatalError("HalfClient", "Lado %s ya fue otorgado\n", side);
    ctl->busy[side]= TRUE;
    if (ctl->verbose)
      nPrintf("nHalfLock de %s otorgado\n", token);
    addToken(ctl, token);
    nSleep(w*ctl->tick);
    if (ctl->verbose)
      nPrintf("nHalfUnLock de %s\n", token);
    ctl->busy[side]= FALSE;
    nHalfUnlock(ctl->l, side);
  }
  return 0;
}

#if 1
static int FullClient(Ctrl ctl, char *token, int w) {
  for (int i= 0; i<ctl->r; i++) {
    if (ctl->verbose)
      nPrintf("nFullLock de %s solicitado\n", token);
    nFullLock(ctl->l, -1);
    if (ctl->busy[0] || ctl->busy[1])
      nFatalError("FullClient", "Al menos un lado ya fue otorgado\n");
    ctl->busy[0]= ctl->busy[1]= TRUE;
    if (ctl->verbose)
      nPrintf("nFullLock de %s otorgado\n", token);
    addToken(ctl, token);
    nSleep(w*ctl->tick);
    if (ctl->verbose)
      nPrintf("nFullUnLock de %s\n", token);
    ctl->busy[0]= ctl->busy[1]= FALSE;
    nFullUnlock(ctl->l);
  }
  return 0;
}
#endif

static int FullTimeout(Ctrl ctl, char *token, int w, int tick_timeout) {
  int cnt= 0;
  int ini= nGetTime();
  int timeout= ctl->tick*tick_timeout;
  for (int i= 0; i<ctl->r; i++) {
    if (ctl->verbose) {
      if (timeout<0)
        nPrintf("nFullLock de %s solicitado\n", token);
      else
        nPrintf("nFullLock de %s solicitado con timeout=%d\n", token, timeout);
    }
    if (!nFullLock(ctl->l, timeout)) {
      if (ctl->verbose)
        nPrintf("nFullLock de %s expirado\n", token);
      if (nGetTime()-ini<timeout)
        nFatalError("FullTimeout", "Timeout expiro antes de tiempo\n");
      cnt++;
    }
    else {
      if (ctl->busy[0] || ctl->busy[1])
        nFatalError("FullTimeout", "Al menos un lado ya fue otorgado\n");
      ctl->busy[0]= ctl->busy[1]= TRUE;
      if (ctl->verbose)
        nPrintf("nFullLock de %s otorgado\n", token);
      addToken(ctl, token);
      nSleep(w*ctl->tick);
      if (ctl->verbose)
        nPrintf("nFullUnLock de %s\n", token);
      ctl->busy[0]= ctl->busy[1]= FALSE;
      nFullUnlock(ctl->l);
    }
  }
  return cnt;
}

// El nuevo test para los timeouts

int timeoutTest(int verbose, int tick) {
  Ctrl ctl= makeCtrl(verbose, tick, 1);

  if (verbose)
    nPrintf("Test: nFullLock con timeout con lock libre\n");

  {
    int time= nGetTime();
    nTask t= nEmitTask(FullTimeout, ctl, "timeout-exito", 0, 10);
    nWaitTask(t);
    int espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera=%d\n", espera);
    verify(0<=espera && espera<=tick/2,
      "nFullLock espera tiempo incorrecto");
    check(ctl, "timeout-exito");
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: nFullLock con timeout que expira\n");

  {
    int time= nGetTime();
    int side= nHalfLock(ctl->l);
    nTask t= nEmitTask(FullTimeout, ctl, "timeout-exp", 0, 1);
    nWaitTask(t);
    nHalfUnlock(ctl->l, side);
    int espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera=%d\n", espera);
    verify(EmptyFifoQueue(ctl->q), "nFullLock entrego TRUE en vez de FALSE");
    verify(tick<=espera && espera<=3*tick/2,
      "nFullLock espera tiempo incorrecto");
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: nFullLock con timeout que no expira\n");

  {
    int time= nGetTime();
    int side= nHalfLock(ctl->l);
    nTask t= nEmitTask(FullTimeout, ctl, "timeout-noexp", 0, 10);
    nSleep(tick);
    nHalfUnlock(ctl->l, side);
    nWaitTask(t);
    int espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera=%d\n", espera);
    verify(tick<=espera && espera<=3*tick/2,
      "nFullLock espera tiempo incorrecto");
    check(ctl, "timeout-noexp");
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 nFullLock con timeout que expiran\n");

  {
    int time= nGetTime();
    int side= nHalfLock(ctl->l);
    nTask t1= nEmitTask(FullTimeout, ctl, "timeout-exp", 0, 1);
    nTask t2= nEmitTask(FullTimeout, ctl, "timeout-exp", 0, 2);
    nWaitTask(t1);
    int espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera de t1=%d\n", espera);
    verify(EmptyFifoQueue(ctl->q), "nFullLock entrego TRUE en vez de FALSE");
    verify(tick<=espera && espera<=2*tick,
      "nFullLock espera tiempo incorrecto");
    nWaitTask(t2);
    nHalfUnlock(ctl->l, side);
    espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera de t2=%d\n", espera);
    verify(EmptyFifoQueue(ctl->q), "nFullLock entrego TRUE en vez de FALSE");
    verify(2*tick<=espera && espera<=5*tick/2,
      "nFullLock espera tiempo incorrecto");
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 nFullLock con timeout, solo uno expira\n");

  {
    int time= nGetTime();
    int side= nHalfLock(ctl->l);
    nTask t1= nEmitTask(FullTimeout, ctl, "timeout-exp", 0, 1);
    nTask t2= nEmitTask(FullTimeout, ctl, "timeout-noexp", 0, 10);
    nWaitTask(t1);
    int espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera de t1=%d\n", espera);
    verify(EmptyFifoQueue(ctl->q), "nFullLock entrego TRUE en vez de FALSE");
    verify(tick<=espera && espera<=2*tick,
      "nFullLock espera tiempo incorrecto");
    nHalfUnlock(ctl->l, side);
    nWaitTask(t2);
    espera= nGetTime()-time;
    check(ctl, "timeout-noexp");
    if (verbose) nPrintf("Tiempo de espera de t2=%d\n", espera);
    verify(EmptyFifoQueue(ctl->q), "nFullLock entrego TRUE en vez de FALSE");
    verify(tick<=espera && espera<=3*tick/2,
      "nFullLock espera tiempo incorrecto");
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: nFullLock con timeout 0 que expira\n");

  {
    int time= nGetTime();
    int side= nHalfLock(ctl->l);
    nTask t= nEmitTask(FullTimeout, ctl, "timeout-exp", 0, 0);
    nWaitTask(t);
    nHalfUnlock(ctl->l, side);
    int espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera=%d\n", espera);
    verify(EmptyFifoQueue(ctl->q), "nFullLock entrego TRUE en vez de FALSE");
    verify(0<=espera && espera<=tick/2,
      "nFullLock espera tiempo incorrecto");
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: nFullLock con timeout 0 que no expira\n");

  {
    int time= nGetTime();
    nTask t= nEmitTask(FullTimeout, ctl, "timeout-noexp", 0, 0);
    nWaitTask(t);
    int espera= nGetTime()-time;
    if (verbose) nPrintf("Tiempo de espera=%d\n", espera);
    verify(0<=espera && espera<=tick/2,
      "nFullLock espera tiempo incorrecto");
    check(ctl, "timeout-noexp");
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose) {
    nPrintf("--------------------------------------------------------------\n");
    nPrintf("Los mismos tests de la tarea 3, pero con timeout que no expira\n");
    nPrintf("\nTest: Un solo nHalfLock\n");
  }

  {
    nTask t= nEmitTask(HalfClient, ctl, "half", 2);
    nSleep(tick);
    check(ctl, "half");
    nWaitTask(t);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: Un solo nFullLock\n");

  {
    nTask t= nEmitTask(FullTimeout, ctl, "full", 3, 10000);
    nSleep(tick);
    check(ctl, "full");
    nWaitTask(t);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 nHalfLock deben ingresar en paralelo\n");

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
    nPrintf("Test: 2 nFullLock deben ingresar secuencialmente\n");

  {
    nTask t1= nEmitTask(FullTimeout, ctl, "full1", 3, 10000);
    nSleep(tick);
    check(ctl, "full1");
    nTask t2= nEmitTask(FullTimeout, ctl, "full2", 2, 10000);
    nSleep(3*tick);
    check(ctl, "full2");
    nWaitTask(t1);
    nWaitTask(t2);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: nFullLock seguido de nHalfLock "
            "deben ingresar secuencialmente\n");

  {
    nTask t1= nEmitTask(FullTimeout, ctl, "full", 3, 10000);
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
    nPrintf("Test: nHalfLock seguido de nFullLock "
            "deben ingresar secuencialmente\n");

  {
    nTask t1= nEmitTask(HalfClient, ctl, "half", 3);
    nSleep(tick);
    check(ctl, "half");
    nTask t2= nEmitTask(FullTimeout, ctl, "full", 2, 10000);
    nSleep(3*tick);
    check(ctl, "full");
    nWaitTask(t1);
    nWaitTask(t2);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 nHalfLock seguidos de 1 nFullLock\n"
            "los primeros deben ingresar en paralelo, luego nFullLock\n");

  {
    nTask t1= nEmitTask(HalfClient, ctl, "half1", 3);
    nSleep(tick);
    check(ctl, "half1");
    nTask t2= nEmitTask(HalfClient, ctl, "half2", 5);
    nSleep(tick);
    check(ctl, "half2");
    nTask t3= nEmitTask(FullTimeout, ctl, "full", 2, 10000);
    nSleep(5*tick);
    check(ctl, "full");
    nWaitTask(t1);
    nWaitTask(t2);
    nWaitTask(t3);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: nHalfLock seguido de nFullLock seguido de nHalfLock\n" 
            "se atienden por orden de llegada\n");

  {
    nTask t1= nEmitTask(HalfClient, ctl, "half1", 3);
    nSleep(tick);
    check(ctl, "half1");
    nTask t2= nEmitTask(FullTimeout, ctl, "full", 2, 10000);
    nSleep(tick);
    nTask t3= nEmitTask(HalfClient, ctl, "half2", 1);
    nSleep(3*tick);
    check(ctl, "full");
    nSleep(2*tick);
    check(ctl, "half2");
    nWaitTask(t1);
    nWaitTask(t2);
    nWaitTask(t3);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: orden ha(3) hb fa hc(3) hd he hf(2) hg fb fc hh hi(2) fd hj hk fe"
            "\ndeben atenderse en unos %d milisegundos\n", 15*tick);

  {
    int ini= nGetTime();
    nTask ha= nEmitTask(HalfClient, ctl, "ha", 2);
    nSleep(tick);
    nTask hb= nEmitTask(HalfClient, ctl, "hb", 1);
    nSleep(tick);
    nTask fa= nEmitTask(FullTimeout, ctl, "fa", 1, 10000);
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
    nTask fb= nEmitTask(FullTimeout, ctl, "fb", 1, 10000);
    nSleep(tick);
    nTask fc= nEmitTask(FullTimeout, ctl, "fc", 1, 10000);
    nSleep(tick);
    nTask hh= nEmitTask(HalfClient, ctl, "hh", 1);
    nSleep(tick);
    nTask hi= nEmitTask(HalfClient, ctl, "hi", 2);
    nSleep(tick);
    nTask fd= nEmitTask(FullTimeout, ctl, "fd", 1, 10000);
    nSleep(tick);
    nTask hj= nEmitTask(HalfClient, ctl, "hj", 1);
    nSleep(tick);
    nTask hk= nEmitTask(HalfClient, ctl, "hk", 1);
    nSleep(tick);
    nTask fe= nEmitTask(FullTimeout, ctl, "fe", 1, 10000);
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
    if (verbose)
      nPrintf("Test: orden ha(3) hb fa hc(3) hd he hf(2) hg "
              "fb fc hh hi(2) fd hj hk fe\n");
    check(ctl, "ha");
    check(ctl, "hb");
    check(ctl, "fa");
    check(ctl, "hc");
    check(ctl, "hd");
    check(ctl, "he");
    check(ctl, "hf");
    check(ctl, "hg");
    check(ctl, "fb");
    check(ctl, "fc");
    check(ctl, "hh");
    check(ctl, "hi");
    check(ctl, "fd");
    check(ctl, "hj");
    check(ctl, "hk");
    check(ctl, "fe");
    int time= nGetTime()-ini;
    if (verbose) nPrintf("Tiempo=%d\n", time);
    if (time>18*tick) {
      nFatalError("timeoutTest", "Asignacion ineficiente del lock\n");
    }
    if (verbose) nPrintf("Limite de tiempo=%d\n", 18*tick);
  }
  return 0;
}

// El nuevo test de robustez para los timeouts

nMonitor rand_mutex= NULL;

long nRandom() {
  nEnter(rand_mutex);
  long res= random();
  nExit(rand_mutex);
  return res;
}

int timeoutRobustez(int m, int r) {
  int cnt= 0;
  Ctrl ctl= makeCtrl(FALSE, 1, r);
  nTask tasks[m];
  nTask t= nEmitTask(FullTimeout, ctl, "wait", m/4, 2000);
  for (int i= 0; i<m; i++) {
    long r= nRandom();
    if (r%2==1)
      tasks[i]= nEmitTask(HalfClient, ctl, "half", 1);
    else
      tasks[i]= nEmitTask(FullTimeout, ctl, "full", 1, (1<<((r/2)%16))-1);
    nSleep(1);
  }
  nWaitTask(t);
  for (int i= 0; i<m; i++) {
    cnt += nWaitTask(tasks[i]);
  }
  return cnt;
}

// Los mismos tests de la tarea 3

int simpleTest(int verbose, int tick) {
  Ctrl ctl= makeCtrl(verbose, tick, 1);

  if (verbose)
    nPrintf("Test: Un solo nHalfLock\n");

  {
    nTask t= nEmitTask(HalfClient, ctl, "half", 2);
    nSleep(tick);
    check(ctl, "half");
    nWaitTask(t);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: Un solo nFullLock\n");

  {
    nTask t= nEmitTask(FullClient, ctl, "full", 3);
    nSleep(tick);
    check(ctl, "full");
    nWaitTask(t);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: 2 nHalfLock deben ingresar en paralelo\n");

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
    nPrintf("Test: 2 nFullLock deben ingresar secuencialmente\n");

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
    nPrintf("Test: nFullLock seguido de nHalfLock "
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
    nPrintf("Test: nHalfLock seguido de nFullLock "
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
    nPrintf("Test: 2 nHalfLock seguidos de 1 nFullLock\n"
            "los primeros deben ingresar en paralelo, luego nFullLock\n");

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
    nPrintf("Test: nHalfLock seguido de nFullLock seguido de nHalfLock\n" 
            "se atienden por orden de llegada\n");

  {
    nTask t1= nEmitTask(HalfClient, ctl, "half1", 3);
    nSleep(tick);
    check(ctl, "half1");
    nTask t2= nEmitTask(FullClient, ctl, "full", 2);
    nSleep(tick);
    nTask t3= nEmitTask(HalfClient, ctl, "half2", 1);
    nSleep(3*tick);
    check(ctl, "full");
    nSleep(2*tick);
    check(ctl, "half2");
    nWaitTask(t1);
    nWaitTask(t2);
    nWaitTask(t3);
    if (verbose) nPrintf("Aprobado\n");
  }

  if (verbose)
    nPrintf("Test: orden ha(3) hb fa hc(3) hd he hf(2) hg fb fc hh hi(2) fd hj hk fe"
            "\ndeben atenderse en unos %d milisegundos\n", 15*tick);

  {
    int ini= nGetTime();
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
    if (verbose)
      nPrintf("Test: orden ha(3) hb fa hc(3) hd he "
              "hf(2) hg fb fc hh hi(2) fd hj hk fe\n");
    check(ctl, "ha");
    check(ctl, "hb");
    check(ctl, "fa");
    check(ctl, "hc");
    check(ctl, "hd");
    check(ctl, "he");
    check(ctl, "hf");
    check(ctl, "hg");
    check(ctl, "fb");
    check(ctl, "fc");
    check(ctl, "hh");
    check(ctl, "hi");
    check(ctl, "fd");
    check(ctl, "hj");
    check(ctl, "hk");
    check(ctl, "fe");
    int time= nGetTime()-ini;
    if (verbose) nPrintf("Tiempo=%d\n", time);
    if (time>18*tick) {
      nFatalError("simpleTest", "Asignacion ineficiente del lock\n");
    }
    if (verbose) nPrintf("Limite de tiempo=%d\n", 18*tick);
  }
  return 0;
}

int robustez(int m, int r) {
  Ctrl ctl= makeCtrl(FALSE, 0, r);
  nTask tasks[m];
  for (int i= 0; i<m; i++) {
    if (nRandom()&1)
      tasks[i]= nEmitTask(HalfClient, ctl, "half", 0);
    else
      tasks[i]= nEmitTask(FullClient, ctl, "full", 0);
    nSleep(1);
  }
  for (int i= 0; i<m; i++) {
    nWaitTask(tasks[i]);
  }
  return 0;
}

int nMain() {
  rand_mutex= nMakeMonitor();

#if 1

  timeoutTest(TRUE, 200);
  nPrintf("Aprobado\n");

  int n= 5;
  nPrintf("\n");
  nPrintf("-----------------------------------------------\n");
  nPrintf("Test: %d tests de timeouts y %d tests de la tarea 3\n",
         (n+1)/2, n-(n+1)/2);
  nPrintf("Solo se muestras los mensajes del primer test\n");
  nPrintf("-----------------------------------------------\n\n");
  nSleep(1000);

  {
    nTask tasks[n];
    for (int i= 0; i<n; i++) {
      tasks[i]= nEmitTask(i%2==0 ? timeoutTest : simpleTest, i==0, 500);
      nSleep(100);
    }
    for (int i= 0; i<n; i++) {
      nWaitTask(tasks[i]);
    }
  }

  nPrintf("Aprobado\n");

  nPrintf("\n");

#endif

  nPrintf("---------------------------------------\n");
  nPrintf("Test de robustez en modo non preemptive\n");
  nPrintf("En mi computador tomo unos 30 segundos\n");
  nPrintf("---------------------------------------\n\n");

  nSetTimeSlice(1);

  {
    int n= 200, m= 100, r= 100;
    nPrintf("%d left/right locks, c/u con %d threads que llaman %d veces "
            "a nHalfLock o nFullLock\n", n, m, r);
    nSleep(1000);
    int ini= nGetTime();
    nTask tasks[n];
    for (int i= 0; i<n; i++) {
      tasks[i]= nEmitTask(i%2==0 ? timeoutRobustez : robustez, m, r);
    }
    int cnt= 0;
    for (int i= 0; i<n; i++) {
      cnt += nWaitTask(tasks[i]);
    }
    int time= nGetTime()-ini;
    nPrintf("El test tomo %d milisegundos\n", time);
    nPrintf("Aprobado, con %d timeouts expirados "
            "de un total de %d solicitudes\n", cnt, n*m*r);
  }
  
  nPrintf("Felicitaciones: aprobo todos los tests\n");

  return 0;
}
