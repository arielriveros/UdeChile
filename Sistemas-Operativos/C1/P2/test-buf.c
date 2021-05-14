#include <nSystem.h>

#include "buf.h"

#define NMAX 30
#define M 5

int valores[M]= { 3, 5, 10, 20, NMAX };

static nTask tasks[NMAX];
static int desordenado;

int cons(Buffer buf, int i) {
  nPrintf("Thread numero %d solicita item\n", i);
  int *pv= get(buf);
  nPrintf("Thread numero %d extrae item %d\n", i, *pv );
  if (i!=*pv) {
    nPrintf("desordenado!\n");
    desordenado= 1;
  }
  nFree(pv);
  return 0;
}
  
int nMain() {
  Buffer buf= makeBuffer(3);
  for (int k=0; k<M; k++) {
    int n= valores[k];
    nPrintf("\n----------------------------------------\n");
    nPrintf("Iniciando: %d threads llaman a get en un buffer vacio\n", n);

    desordenado= 0;

    for (int i= 0; i<n; i++) {
      nSleep(300);
      tasks[i]= nEmitTask(cons, buf, i);
    }

    nPrintf("\n<<< Se depositan %d itemes 0, 1, 2, etc.>>>\n\n", n);

    for (int i= 0; i<n; i++) {
      int *pv= nMalloc(sizeof(int));
      *pv= i;
      put(buf, pv);
    }

    for (int i= 0; i<n; i++)
      nWaitTask(tasks[i]);

    if (desordenado)
      nFatalError("nMain", "Los threads no respetaron orden de llegada\n");
    else
      nPrintf("Bien.  Se respeto orden de llegada.\n");
  }

  nPrintf("Felicitaciones: su tarea funciona.\n");

  return 0;
}

