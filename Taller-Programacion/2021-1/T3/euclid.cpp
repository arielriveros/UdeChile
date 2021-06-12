/* 
From Euclid it is known that for any positive integers A and B there exist such integers X and Y that
AX + BY = D, where D is the greatest common divisor of A and B. The problem is to find for given
A and B corresponding X, Y and D.
*/

#include <iostream>
using namespace std;

int a, b, x, y, gcd;
void euclid(int in_a, int in_b) {
    if(in_b == 0) {
        gcd = in_a;
        x = 1;
        y = 0;
    }
    else {
        euclid(in_b, in_a%in_b);
        int aux = x;
        x = y;
        y = aux - (in_a/in_b)*y;
    }
}

int main() {
    cin >> a >> b;
    euclid(a, b);
    cout << x << " " << y << " " << gcd << endl;
    return 0;   
}