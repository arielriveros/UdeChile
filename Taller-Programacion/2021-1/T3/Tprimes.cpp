/* 
We know that prime numbers are positive integers that have exactly two distinct 
positive divisors. Similarly, we'long long call a positive integer t Т-prime, if t has 
exactly three distinct positive divisors. 
You are given an array of n positive integers. For each of them determine whether 
it is Т-prime or not. 
*/

#include <iostream>
#include <cmath>
using namespace std;

int main(){
   const int bound = 1e6+1;
   int n, s=0;
   int nums[bound], arr[bound];
   nums[1] = {1};
   while(s < bound){
      nums[s] = s;
      s++;
   }
   std::cin >> n;
   for(int i = 2;i < bound;i++){
      if(nums[i] == i){
         for(int j = i; j < bound; j+=i){
            if(j - ((nums[j]/i) * (i-1)) == 1){
               arr[j] = 1;
            }else{
               nums[j] /=  i*(i-1);
            }
         }
      }
   }
   for(int i = 1; i <= n; i++){
   	    long long k;
   	    std::cin >> k;
   	    long long x = abs(sqrt(k));
   	    if( pow(x,2) == k && arr[x] == 1){
		    std::cout << "YES" << std::endl;
	    }
	    else{
		    std::cout << "NO" << std::endl;
	    }
	}
   return 0;
}