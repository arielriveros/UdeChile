/* 
We know that prime numbers are positive integers that have exactly two distinct 
positive divisors. Similarly, we'll call a positive integer t Т-prime, if t has 
exactly three distinct positive divisors. 
You are given an array of n positive integers. For each of them determine whether 
it is Т-prime or not. 
*/

#include <iostream>
#include <algorithm>
#include <cstdio>
#include <cmath>
#include <string>
using namespace std;
typedef long long ll;
const int maxn = 1000005;
int e[maxn],a[maxn];
void solve(){
   e[1] = 1;
   for(int i = 2; i < maxn; i++){
      e[i] = i;
   }
   for(int i = 2;i < maxn;i++){
      if(e[i] == i){
         for(int j = i; j < maxn; j= j + i){
            e[j] = e[j] / i * (i-1);
            if(j - e[j] == 1){
               a[j] = 1;
            }
         }
      }
   }
}
int main(){
   int n;
   cin >> n;
   solve();
   for(int i = 1; i <= n; i++){
   	    ll k;
   	    cin >> k;
   	    ll x = sqrt(k);
   	    if(x * x == k && a[x] == 1){
		    cout << "YES" << endl;
	    }
	    else{
		    cout << "NO" << endl;
	    }
	}
   return 0;
}