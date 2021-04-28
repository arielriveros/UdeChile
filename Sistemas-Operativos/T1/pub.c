#include <nSystem.h>
#include <fifoqueues.h>
#include "pub.h"
nSem mutex;
int esperan[2]= {0, 0};
int adentro[2]= {0, 0};
FifoQueue colas[2];
void ini_pub() {
  mutex = nMakeSem(1);
  colas[0] = MakeFifoQueue();
  colas[1] = MakeFifoQueue();
}
void entrar(int sexo) {
  int opuesto = !sexo;
  nWaitSem(mutex);
  if (adentro[opuesto] || esperan[opuesto]!=0) {
    //esperan[sexo]++;
    nSignalSem(mutex); 
    nSem n = nMakeSem(0); 
    PutObj(colas[sexo], n); 
    nWaitSem(n);
    nDestroySem(n);
  }else{
    adentro[sexo]++;
    nSignalSem(mutex);
  }
}
void salir(int sexo) {
  int opuesto= !sexo;
  nWaitSem(mutex);
  adentro[sexo]--;
  if (adentro[sexo]==0){
    while(!EmptyFifoQueue(colas[opuesto])){
      nSignalSem(PeekObj(colas[opuesto]));
      DeleteObj(colas[opuesto], PeekObj(colas[opuesto]));
      adentro[opuesto]++;
    }
  }
  esperan[opuesto]= 0;
  nSignalSem(mutex);
}