/* 
From Euclid it is known that for any positive integers A and B there exist such integers X and Y that
AX + BY = D, where D is the greatest common divisor of A and B. The problem is to find for given
A and B corresponding X, Y and D.
*/

#include <iostream>
using namespace std;

int a, b, d, x, y;
void euclid(int A, int B) {
    if(B == 0) {
        d = A;
        x = 1;
        y = 0;
    }
    else {
        euclid(B, A%B);
        int temp = x;
        x = y;
        y = temp - (A/B)*y;
    }
}

int main() {
    cin >> a >> b;
    euclid(a, b);
    cout << x << " " << y << " " << d << endl;
    return 0;   
}