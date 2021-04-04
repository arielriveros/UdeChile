#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include "integral.h"

double resultado;

typedef struct {
    Funcion f;
    void *ptr;
    int n;
    double x_i, x_f,  res;
    pthread_t thread_id;
} Args;

void *integral_thread(void *ptr){
    Args *args = (Args*)ptr;
    resultado += integral(args->f, args->ptr, args->x_i, args->x_f, args->n);
    return NULL;
}

double integral_par(Funcion f, void *ptr, double xi, double xf, int n, int p){
    Args *args_a = (Args*)malloc(p*sizeof(Args));
    double k = (xf-xi)/p ;
    int i;
    for(i = 0; i < p; i++){
        Args* arg = &args_a[i];
        arg -> f = f;
        arg -> x_i = xi+i*k;
        arg -> x_f = xi+(i+1)*k;
        arg ->ptr = ptr;
        arg -> n = n/p;
        pthread_create(&arg->thread_id, NULL, integral_thread, arg);
        }

    for(i = 0; i < p; i++){
        Args *args = &args_a[i];
        pthread_join(args->thread_id, NULL);
    }
    double res = resultado;
    resultado = 0;
    return res;
}
