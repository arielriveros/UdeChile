#include <iostream>

/* 
Pavel loves grid mazes. A grid maze is an n × m rectangle maze where 
each cell is either empty, or is a wall. You can go from one cell 
to another only if both cells are empty and have a common side.

Pavel drew a grid maze with all empty cells forming a connected area. 
That is, you can go from any empty cell to any other one. 
Pavel doesn't like it when his maze has too little walls. 
He wants to turn exactly k empty cells into walls so that all the remaining 
cells still formed a connected area. Help him.
 */

using namespace std;
int m,n,k,s1,s2;
char OutMatrix[501][501];
bool VisitMatrix[501][501];
int p[4]={1,-1,0,0};
int q[4]={0,0,-1,1};

bool dfs(int r,int c){
    s2++;
    VisitMatrix[r][c]=true;
    if(s1==s2){
        return true;
    }
    for(int i=0; i<4; i++){
        if(!VisitMatrix[r+p[i]][c+q[i]]  && 
                (1<=r+p[i] && r+p[i]<=m && 1<=c+q[i] && c+q[i]<=n) &&
                    OutMatrix[r+p[i]][c+q[i]]=='.'){
            if(dfs(r+p[i],c+q[i])){
                return true;
            }
        }
    }
    return false;
}

void solve(){
    for(int i=1;i<=m;i++){
        for(int j=1;j<=n;j++){
            if(!VisitMatrix[i][j]){
                s2=0;
                if(dfs(i,j)){
                    for(int i=1; i <= m; i++){
                        for(int j=1;j<=n;j++){
                            if(!VisitMatrix[i][j]){
                                OutMatrix[i][j]='X';
                            }
                        }
                    }
                    for(int i=1;i<=m;i++){
                        for(int j=1;j<=n;j++){
                            cout<<OutMatrix[i][j];
                        }
                        cout<<endl;
                    }
                    return;
                }else{
                    for(int i=1; i <= m; i++){
                        for(int j=1;j<=n;j++){
                            if(OutMatrix[i][j]=='.'){
                                VisitMatrix[i][j]=false;
                            }
                        }
                    }
                }
            }
        }
        
    }
}

int main(){
    while(cin>>m>>n>>k){
        s1 = m*n-k;
        for(int i=1;i<=m;i++){
            for(int j=1;j<=n;j++){
                cin >> OutMatrix[i][j];
                if(OutMatrix[i][j] == '#'){
                    VisitMatrix[i][j] = 1;
                    s1--;
                }
            }
        }
        solve();
    }
}