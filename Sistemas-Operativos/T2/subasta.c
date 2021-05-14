#include <nSystem.h>
#include "subasta.h"
// =============================================================
// Use esta cola de prioridades para resolver el problema
// =============================================================

// Puede almacenar hasta 100 elementos.  No se necesita mas para el test.

#define MAXQSZ 100

typedef int bool;
#define true 1
#define false 0


typedef struct {
  void **vec;
  double *ofertas;
  int size, maxsize;
} *PriQueue;

PriQueue MakePriQueue(int size);    // Constructor
void DestroyPriQueue(PriQueue pq);  // Destructor

// Las operaciones
void *PriGet(PriQueue pq);          // Extraer elemento de mejor prioridad
void PriPut(PriQueue pq, void* t, double pri); // Agregar con prioridad
int PriBest(PriQueue pq);           // Prioridad del mejor elemento
int EmptyPriQueue(PriQueue pq);     // Verdadero si la cola esta vacia
int PriLength(PriQueue pq);         // Largo de la cola

// =============================================================
// Implemente a partir de aca el tipo Subasta
// =============================================================


////////////////////////////////////////////////////////////////////

struct subasta {
  PriQueue queue;
  nMonitor monitor;
  int N, aportes;
  bool abierta;
};

typedef struct{
  nCondition condicion;
  bool contra;
} Oferta;

Subasta nuevaSubasta(int unidades){
  Subasta s = (Subasta)nMalloc(sizeof(*s));
  s-> queue = MakePriQueue(unidades);
  s-> monitor = nMakeMonitor();
  s-> N = unidades;
  s->aportes = 0;
  s-> abierta = true;
  return s;
}

bool ofertar(Subasta s, double precio) {
  bool out = false;
  Oferta o;
  o.condicion = nMakeCondition(s->monitor);
  o.contra = false;
  PriPut(s->queue, &o, precio);
  while(!o.contra && s->abierta){
    nWaitCondition(o.condicion);
  }
  nDestroyCondition(o.condicion);
  if(o.contra) out = false;
  else if (!(s->abierta)) out = true;
  return out;
}

bool ofrecer(Subasta s, double precio){
  bool out;
  nEnter(s->monitor);
  if((PriLength(s->queue) < s->N) && (s->abierta)){
    out = ofertar(s,precio);
  }
  else if (!(s->abierta)) out = false;
  else if ( PriBest(s->queue) < precio){
    Oferta* peorOferta = PriGet(s->queue);
    peorOferta->contra = true;
    nSignalCondition(peorOferta->condicion);
    out = ofertar(s , precio);
  }
  else out = false;
  nExit(s->monitor);
  return out;
}

double adjudicar(Subasta s, int *punidades){
  nEnter(s->monitor);
  s->abierta = false;
  double ganancia = 0;
  while(!EmptyPriQueue(s->queue)){
    ganancia += PriBest(s->queue);
    Oferta* aux = PriGet(s->queue);
    nSignalCondition(aux->condicion);
    s->aportes++;
  }
  nExit(s->monitor);
  *punidades = s->N - s->aportes;
  return ganancia;
}

void destruirSubasta(Subasta s){
  DestroyPriQueue(s->queue);
  nDestroyMonitor(s->monitor);
  nFree(s);
}

// =============================================================
// No toque nada a partir de aca: es la implementacion de la cola
// de prioridades
// =============================================================

PriQueue MakePriQueue(int maxsize) {
  PriQueue pq= nMalloc(sizeof(*pq));
  pq->maxsize= maxsize;
  pq->vec= nMalloc(sizeof(void*)*(maxsize+1));
  pq->ofertas= nMalloc(sizeof(double)*(maxsize+1));
  pq->size= 0;
  return pq;
}

void DestroyPriQueue(PriQueue pq) {
  nFree(pq->vec);
  nFree(pq->ofertas);
  nFree(pq);
}

void *PriGet(PriQueue pq) {
  void *t;
  int k;
  if (pq->size==0)
    return NULL;
  t= pq->vec[0];
  pq->size--;
  for (k= 0; k<pq->size; k++) {
    pq->vec[k]= pq->vec[k+1];
    pq->ofertas[k]= pq->ofertas[k+1];
  }
  return t;
}

void PriPut(PriQueue pq, void *t, double oferta) {
  if (pq->size==pq->maxsize)
    nFatalError("PriPut", "Desborde de la cola de prioridad\n");
  int k;
  for (k= pq->size-1; k>=0; k--) {
    if (oferta > pq->ofertas[k])
      break;
    else {
      pq->vec[k+1]= pq->vec[k];
      pq->ofertas[k+1]= pq->ofertas[k];
    }
  }
  pq->vec[k+1]= t;
  pq->ofertas[k+1]= oferta;
  pq->size++;
}

int PriBest(PriQueue pq) {
  return pq->size==0 ? 0 : pq->ofertas[0];
}

int EmptyPriQueue(PriQueue pq) {
  return pq->size==0;
}

int PriLength(PriQueue pq) {
  return pq->size;
}
