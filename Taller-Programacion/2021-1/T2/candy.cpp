/* Little Charlie is a nice boy addicted to candies. He is even a subscriber to 
All Candies Magazine and was selected to participate in the International Candy Picking Contest.
In this contest a random number of boxes containing candies are disposed in M rows with N 
columns each (so, there are a total of M ×N boxes). Each box has a number indicating how 
many candies it contains.
The contestant can pick a box (any one) and get all the candies it contains. But there 
is a catch (there is always a catch): when choosing a box, all the boxes from the rows 
immediately above and immediately below are emptied, as well as the box to the left 
and the box to the right of the chosen box. The contestant continues to pick a box 
until there are no candies left.
The figure bellow illustrates this, step by step. Each cell represents one box and the number 
of candies it contains. At each step, the chosen box is circled and the shaded cells represent 
the boxes that will be emptied. After eight steps the game is over and 
Charlie picked 10+9+8+3+7+6+10+1 = 54 candies. */

#include <iostream>
using namespace std;
int main(){
    int N,M,a,b,c,A,B,C;
    int out[100];
    int n = 0;
    while(true){
        cin >> N >> M;
        if (N == 0 && M == 0){
            break;
        }
        for(int i = A = B = 0; i < N; i++){
            for(int j = a = b = 0; j < M; j++){
                cin >> c;
                c = max(a+c,b);
                a = b;
                b = c;
            }
            C = max(A+c,B);
            A = B;
            B = C;
        }
        out[n] = C;
        n++;
    }
    for(int i=0;i<n;i++){
        cout << out[i] << endl;
    }
    return 0;
}