#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "t1.h"

uint comprimir(uint *a, int nbits){
    uint mask = 1;
    mask = (mask<<nbits) - 1;
    uint output = 0;
    uint bound = sizeof(a) >> 2;
    uint aux = 0;
    for(int i = 0; i <= bound; i++){
        aux = *(a+i);
        output <<= nbits;
        output |= aux&mask;
    }
    return output;
}

char *insercion(char *d, char *s){
    char *output = (char*)malloc(sizeof(char)*(strlen(d)+strlen(s))+1);
    output = strcat(strcpy(output, s),d);
    return output;
}

void insertar(char *d, char *s){
    char* p = d + strlen(d) + strlen(s) - 1;
    char *q = d + strlen(s);
    while(*q){
        *p = *q;
        p--; q--;
    }
    while(*s){
        *d = *s;
        d++;
        s++;
    }
}
