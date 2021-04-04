#include <stdio.h>
#include "t2.h"

int calzar(Nodo *a, Nodo **ppat){
    Nodo *aux = *ppat;
    if (aux == NULL){
        *ppat=a;
        return 1;
    }
    if(a==NULL || aux->x != a->x){
        return 0;
    }
    if(calzar(a->izq, &((*ppat)->izq))==1 && calzar(a->der, &((*ppat)->der)) == 1){
        return 1;
    }
    return 0;
}
