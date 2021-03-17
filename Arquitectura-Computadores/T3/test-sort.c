#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void sort(char *noms[], int n);

// La estructura de una persona

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

int main() {
  sort(noms, 12);
  for (int i= 0; i<12; i++)
    puts(noms[i]);
  return 0;
}
