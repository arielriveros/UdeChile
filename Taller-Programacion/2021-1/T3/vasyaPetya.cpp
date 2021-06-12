
/* 

Vasya and Petya are playing a simple game. Vasya thought of number x between 1 and n, and Petya tries to guess the number.
Petya can ask questions like: "Is the unknown number divisible by number y?".
The game is played by the following rules: first Petya asks all the questions that interest him (also, he can ask no questions), 
and then Vasya responds to each question with a 'yes' or a 'no'. After receiving all the answers Petya should determine the number that Vasya thought of.
Unfortunately, Petya is not familiar with the number theory. Help him find the minimum 
number of questions he should ask to make a guaranteed guess of Vasya's number, and the numbers yi, he should ask the questions about.

 */

#include <iostream>

using namespace std;
const int bound = 1e6+1;
int n, sum[1001];
long outputArr[bound];

int prime(long x, long y){
	while(x%y==0) x = x/y;
	if(x==1) return 1;
	else return 0; 
}
int main(){
	cin>>n;
	int k = 0;
	long long s=0;
	int i = 2;
	while(i<=n){
		if(sum[i]==0){
			outputArr[k] = i;
			k++; s++;
			for(int j=2;j*i<=n;j++){
				if(prime(j,i)){
					outputArr[k] = i*j;
					s++; k++;
				}
				sum[j*i]=1;
			}
		}
		i++;
	}
	cout << s << endl;
	for(int i = 0;i < k; i++){
		cout << outputArr[i] << " ";
	}
	cout << endl;
}