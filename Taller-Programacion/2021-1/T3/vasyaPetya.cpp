
/* 

Vasya and Petya are playing a simple game. Vasya thought of number x between 1 and n, and Petya tries to guess the number.
Petya can ask questions like: "Is the unknown number divisible by number y?".
The game is played by the following rules: first Petya asks all the questions that interest him (also, he can ask no questions), 
and then Vasya responds to each question with a 'yes' or a 'no'. After receiving all the answers Petya should determine the number that Vasya thought of.
Unfortunately, Petya is not familiar with the number theory. Help him find the minimum 
number of questions he should ask to make a guaranteed guess of Vasya's number, and the numbers yi, he should ask the questions about.

 */

#include<bits/stdc++.h>
#define MAX 1e3+1

using namespace std;
int n, vis[1001];
queue<long>q;
bool check(long y, long p)
{
	while(y%p==0)
	{
		y/=p;
	}
	if(y==1)
	return true;
	else
	return false; 
}
int main()
{
	cin>>n;
	long long s=0;
	for(int i=2;i<=n;i++)
	{
		if(vis[i]==0)
		{
			s++;
			q.push(i);
			for(int j=2;j*i<=n;j++)
			{
				if(check(j,i))
				{
					s++;
					q.push(j*i);
				}
				vis[j*i]=1;
			}
		}
	}
	cout << s << endl;
	while(!q.empty())
	{
		long long x=q.front();
		cout<<x<<" ";
		q.pop();
	}
	cout << endl;
}