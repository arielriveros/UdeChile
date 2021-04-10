#include <nSystem.h>

int escritor(int id, int espera);

int nMain() {
	nTask tareas[3];	
	for (int i = 0; i < 3; ++i)
		tareas[i] = nEmitTask(escritor, i, i * 200);
	for (int i = 0; i < 3; ++i)
		nWaitTask(tareas[i]);
	nPrintf("Fin ejemplo\n");
	return 0;
}

int escritor(int id, int espera) {
	for (int i=0; i<5; i++) {
	    nPrintf("thread %d: %d\n", id, i);
	    nSleep(espera);
	}
	return 0;
}
