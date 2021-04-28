#include <nSystem.h>
#include "pub.h"
nSem m;
nSem q_sem[2];
int esperan[2]= {0, 0};
int adentro[2]= {0, 0};

void ini_pub() {
  m= nMakeSem(1);
  q_sem[0]= nMakeSem(0);
  q_sem[1]= nMakeSem(0);
}
void entrar(int sexo) {
  int opuesto= !sexo;
  nWaitSem(m);
  if (adentro[opuesto] || esperan[opuesto]!=0) {
    esperan[sexo]++;
    nSignalSem(m);
    nWaitSem(q_sem[sexo]);
  }
  adentro[sexo]++;
  nSignalSem(m);
}
void salir(int sexo) {
  int opuesto= !sexo;
  nWaitSem(m);
  adentro[sexo]--;
  if (adentro[sexo]==0) {
    for (int i= 0; i<esperan[opuesto]; i++) {
      nSignalSem(q_sem[opuesto]);
    }
    esperan[opuesto]= 0;
  }
  nSignalSem(m);
}