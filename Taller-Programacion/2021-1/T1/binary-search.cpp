#include <iostream>

/* Dado un arreglo (vector) de N enteros ordenados de forma no decreciente, 
se realizaran Q consultas, cada una consta de un entero. 
Utilice búsqueda binaria para responder el indice de la primera 
ocurrencia del entero solicitado en el arreglo.

Input
En la primera linea recibirá un entero N (1 <= N <= 10^5) y un entero Q (1 <= Q <= 10^5).
En la segunda linea hay N enteros separados por espacios, cada entero toma un valor entre 1 y 10^9.
A continuación siguen Q lineas, cada una con un entero entre 1 y 10^9, representando una consulta.

Output
Por cada consulta (en el orden en que estas fueron recibidas) 
imprima una linea que consiste de un entero, el índice de la primera aparición del elemento consultado, 
o -1 si no está presente en los N enteros iniciales. */

int binarySearch(int arr[], int left, int right, int key){
    if (right >= left) {
        int mid = left + (right - left) / 2;
        if ((mid == 0 || key > arr[mid - 1]) && arr[mid] == key){
            return mid;
        }
        else if (key > arr[mid])
            return binarySearch(arr, (mid + 1), right, key);
        else
            return binarySearch(arr, left, (mid - 1), key);
    }
    return -1;
}


int main(){
    int N = 1e5, Q = 1e5;
    const int bound = 1e5; 
    int arr[bound], query[bound];
    std::cin >> N >> Q;
    for (int i = 0; i < N; i++){
        std::cin >> arr[i];
    }
    for (int i = 0; i < Q; i++){
        std::cin >> query[i];
    }
    for (int i = 0; i < Q; i++){
        int left = 0, right = N;
        std::cout << binarySearch(arr,left,right,query[i]) << std::endl;
    }
    return 0;
}

/* 10 4 1 3 4 5 5 6 7 8 8 17 3 5 9 1 */