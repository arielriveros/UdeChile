#include <nSystem.h>
#include "pub.h"

// DAMA==1 y VARON==0

nSem m; // = nMakeSem(1); para la exclusion mutua

// En q_sem[DAMA] esperan las damas, en q_sem[VARON] esperan los varones
nSem q_sem[2]; // = nMakeSem(0) x 2;
int esperan[2]= {0, 0}; // personas esperando de cada sexo
int adentro[2]= {0, 0}; // personas dentro del baño de cada sexo

void ini_pub() {
  m= nMakeSem(1);
  q_sem[0]= nMakeSem(0);
  q_sem[1]= nMakeSem(0);
}

void entrar(int sexo) {
  int opuesto= !sexo; // Si entra DAMA, opuesto es VARON
  nWaitSem(m);
  if (adentro[opuesto] || esperan[opuesto]!=0) {
    // Se espera si el banno esta ocupado por personas del sexo opuesto o
    // si hay personas esperando del sexo opuesto
    esperan[sexo]++;
    nSignalSem(m);
    nWaitSem(q_sem[sexo]); // Se coloca al thread en espera
    nWaitSem(m);
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

