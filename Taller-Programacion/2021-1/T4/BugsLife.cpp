#include<iostream>
using namespace std;

/* 
Professor Hopper is researching the sexual behavior of a rare species of bugs. 
He assumes that they feature two different genders and that they only interact 
with bugs of the opposite gender. In his experiment, individual bugs and 
their interactions were easy to identify, because numbers were printed on their backs.

Given a list of bug interactions, decide whether the experiment supports his assumption 
of two genders with no homosexual bugs or if it contains some bug interactions that falsify it.
 */


int Arr[2001], Vis[2001];
bool checkSus = false;

int graphOut(int x){
    if(x == Arr[x]) return x;
    int t = graphOut(Arr[x]);
    Vis[x] = (Vis[x] + Vis[Arr[x]]) & 1; 
    Arr[x] = t;
    return t;
}

void unionSet(int x,int y){
    int t[2] = {graphOut(x), graphOut(y)};
    if(t[0] != t[1]){
        Arr[t[1]] = t[0];
        Vis[t[1]] = (Vis[x] + Vis[y] + 1) & 1;
        return ;
    }
    if(Vis[x] == Vis[y]) checkSus = true;
}

int main(){
    int scenarios;
    cin >> scenarios;
    int c = 0;
    while(scenarios--){
        c++;
        int nBugs, nInteractions;
        cin >> nBugs >> nInteractions;
        for(int i = 1; i <= nBugs; i++) Arr[i] = i, Vis[i] = 0;
        checkSus = false;
        while(nInteractions--){
            int x, y;
            cin >> x >> y;
            if(checkSus) continue;
            unionSet(x,y);
        }
        cout << "Scenario #" << c << ":" << endl;
        checkSus ? cout << "Suspicious bugs found!" << endl : cout << "No suspicious bugs found!" << endl;
        cout << endl;
    }
    return 0;
}