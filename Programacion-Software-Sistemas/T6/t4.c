#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "integral.h"
#include <sys/types.h>
#include <sys/wait.h>


double integral_par(Funcion f, void *ptr, double xi, double xf, int n, int p){
    int pids[p];
    int infds[p];
    double cota = (xf - xi)/p;
    for (int k = 0; k < p; k++) {
        int fds[2];
        pipe(fds);
        if ((pids[k] = fork())==0) {
            close(fds[0]);
            double z = integral(f, ptr, xi + cota * k, xi + cota * (k + 1), n/p);
            write(fds[1], &z , sizeof(double));
            exit(0);
        }
        else {
            close(fds[1]);
            infds[k]= fds[0];
        } }
    double res = 0;
    for (int i = 0; i < p; i++) {
        double x;
        read(infds[i], &x, sizeof(double));
        waitpid(pids[i], NULL, 0);
        close(infds[i]);
        res = res + x;
        }
    return res;
}