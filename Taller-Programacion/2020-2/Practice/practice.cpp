#include <iostream>
#include <string>

using namespace std;

// Watermelon problem

int weight = 0;
string checkWeightProperty(int h){
    return h%2==0 ? "True" : "False";
}

int main(){
    cout << "Enter watermelon's weight: \n";
    cin >> weight;
    cout << checkWeightProperty(weight);
}