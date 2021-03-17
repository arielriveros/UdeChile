#include <string.h>
#include <stdio.h>

void sort(char noms, int n) {
    char ult= &noms[n-1];
    char *p= noms;
    while (p<ult) {
        // Piense bien su solucion tratando de minimizar el numero
        // de lineas de codigo porque debera traducirlo a assembler.
        // Modifique desde aca
        int cmp=0;
        char a=p[0];
        char* b=p[1];
        while(*a!='\0'){
            int letra1= *a;
            int letra2= *b;
            if('A'<=letra1 && letra1<='Z'){
                letra1='a'+letra1-'A';
            }
            if('A'<=letra2 && letra2<='Z'){
                letra2='a'+letra2-'A';
            }
            int resta;
            resta=letra1-letra2;
            if(resta>0){
                cmp=1;
                break;
            }
            if(resta<0){
                cmp=-1;
                break;
            }
            if(resta==0){
                a++;
                b++;
            }
        }
        // hasta aca para cambiar el criterio de ordenamiento
        if (cmp<=0)
            p++;
        else {
            char *tmp= p[0];
            p[0]= p[1];
            p[1]= tmp;
            p= noms;
        }
    }
}

int main(){
    char *noms[]= {"Gonzalez peDro",
                   "pereZ juan" ,
                   "gonzalez Diego",
                   "gonzalez ana",
                   "fernandez veri",
                   "perez josefa",
                   "fernandez monica",
                   "perez alberto",
                   "FERNANDEZ maria",
                   "jerez tatiana",
                   "PEREZ JOSE",
                   "Gonzalez DIEGO"};
    sort(noms, 12);
    for (int i= 0; i<12; i++)
        puts(noms[i]);
    return 0;
}