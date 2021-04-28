#include <nSystem.h>

nMonitor m;

int escritor(int id, int espera);

int nMain() {
    m = nMakeMonitor();
	nTask tareas[3];
	for (int i = 0; i < 3; ++i)
		tareas[i] = nEmitTask(escritor, i, i * 200);
	for (int i = 0; i < 3; ++i)
		nWaitTask(tareas[i]);
	nPrintf("Fin ejemplo\n");
	return 0;
}

int escritor(int id, int espera) {
    nEnter(m);
	for (int i=0; i<5; i++) {
	    nPrintf("thread %d: %d\n", id, i);
	    nSleep(espera);
	}
	nExit(m);
	return 0;
}
