
#include <bits/stdc++.h>
using namespace std;
int vis[1111];
int main()  
{  
	int n,m;
	cin >> n >> m;
	for(int i=0;i<m;i++)
	{
		int mid1,mid2;
		cin >> mid1 >> mid2;
		vis[mid1]=1;
		vis[mid2]=1;
	}
	int tot;
	for(int i=1;i<=n;i++)
	{
		if(!vis[i])
			{	
				tot=i;
				break;
			}
	}
	cout << n-1 << endl;
} 