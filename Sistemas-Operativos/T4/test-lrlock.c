#include <nSystem.h>
#include <fifoqueues.h>
#include <string.h>

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
    nPrintf("Test: orden ha(3) hb fa hc(3) hd he hf(2) hg fb fc hh hi(2) fd hj hk fe");
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
    nPrintf("Tiempo=%d\n", time);
    if (time>18*tick) {
      nFatalError("simpleTest", "Asignacion ineficiente del lock\n");
    }
    nPrintf("Limite de tiempo=%d\n", 18*tick);
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
  simpleTest(TRUE, 200);

  int n= 5;
  nPrintf("\n");
  nPrintf("-----------------------------------------------\n", n);
  nPrintf("Test: %d veces los tests anteriores en paralelo\n", n);
  nPrintf("Solo se muestras los mensajes del primer test\n");
  nPrintf("-----------------------------------------------\n\n", n);
  nSleep(1000);

  {
    nTask tasks[n];
    for (int i= 0; i<n; i++) {
      tasks[i]= nEmitTask(simpleTest, i==0, 500);
      nSleep(100);
    }
    for (int i= 0; i<n; i++) {
      nWaitTask(tasks[i]);
    }
    nPrintf("Aprobado\n");
  }

  nPrintf("\n");
  nPrintf("---------------------------------------\n");
  nPrintf("Test de robustez en modo non preemptive\n");
  nPrintf("---------------------------------------\n\n");


  nSetTimeSlice(1);

  {
    int n= 50, m= 50, r= 50;
    nPrintf("%d left/right locks, c/u con %d threads que llaman %d veces\n",
            n, m, r);
    nPrintf("a nHalfLock y %d threads que llaman %d veces nFullLock\n",
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
