/* Dima, Inna and Seryozha have gathered in a room. That's right, 
someone's got to go. To cheer Seryozha up and inspire him to have a walk, Inna decided to cook something.
Dima and Seryozha have n fruits in the fridge. Each fruit has two parameters: 
the taste and the number of calories. Inna decided to make a fruit salad, 
so she wants to take some fruits from the fridge for it. Inna follows a certain 
principle as she chooses the fruits: the total taste to the total calories ratio 
of the chosen fruits must equal k. 
Inna hasn't chosen the fruits yet, she is thinking: what is the maximum taste of the chosen fruits 
if she strictly follows her principle? Help Inna solve this culinary problem — now 
the happiness of a young couple is in your hands!
Inna loves Dima very much so she wants to make the salad from at least one fruit. */

#include <iostream>
#include <cstring>
int n, k, mat[101][20002], a[101], b[101], c[101];
int main(int argc, char *argv[]){
    std::cin>>n>>k;
    memset(mat,-1,sizeof(mat));
    for(int i=1;i<=n;i++){
        std::cin>>a[i];
    }
    for(int i=1;i<=n;i++){
        std::cin>>b[i];
    }
    for(int i=1;i<=n;i++){
        c[i]=k*b[i]-a[i];
    }
    mat[0][10000]=0;
    for(int i=1;i<=n;i++){
        for(int j=20000;j>=0;j--){
            if(j-c[i]>=0 && j-c[i]<=20000){
                if(mat[i-1][j-c[i]]!=-1){
                    mat[i][j]=std::max(mat[i][j],mat[i-1][j-c[i]]+a[i]);
                }
            }
            mat[i][j]=std::max(mat[i-1][j],mat[i][j]);
        }
    }
    if(mat[n][10000]!=0){
        std::cout << mat[n][10000] << std::endl;
    }else{
        std::cout << -1 << std::endl;
    }
    return 0;
}