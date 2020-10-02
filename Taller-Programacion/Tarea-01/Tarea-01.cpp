#include <iostream>
#include <algorithm>
#include <cmath>
#include <time.h>
#include <ctime>
#include <climits>
#include <stdio.h>
using namespace std;
clock_t start, endd;
/*
input
	integer n	number of piles of worms
	n integers	a1 a2 ... an where ai is number of worms
	integer m	number of juicy worms
	m integers	labels of juicy worms

output
	m lines in std, line i is label of juicy worm in ith pile

ex
	input
		5
		2 7 3 4 9
		3
		1 25 11
	output
		1
		5
		3
*/

/*
int wormsBS(int juicy, int* arr, int lower, int upper) {
	int mid, out = 0;
	if (lower <= upper) {
		mid = (lower + upper) / 2;
		if (juicy <= arr[mid]) {
			if (juicy > arr[mid - 1]) out = mid+1;
			else return wormsBS(juicy, arr, lower, mid - 1);
		}
		else {
			if (juicy <= arr[mid]) out = mid + 2;
			else return wormsBS(juicy, arr, mid + 1, upper);
		}
	}
	return out;
}
*/
int wormsMain() {
	int n, m, labels = 0;
	scanf("%d", &n);
	int* arr = new int[n];
	int* juicy = new int[m];
	for (int i = 0; i < n; i++)           
	scanf("%d", &arr[i]);    
	scanf("%d", &m);         
	for (int i = 0; i < m; i++)
	scanf("%d", &juicy[i]);

	for (int i = 0; i < n; i++)
	{
		labels += arr[i];       
		arr[i] = labels;
	}
	int mid;
	for (int i = 0; i < m; i++)
	{
		int lower = 0, upper = n;
		while (lower <= upper - 1){
			mid = (lower + upper) / 2;
			if (arr[mid] == juicy[i]) { printf("%d\n", mid + 1); break; }
			else if (arr[mid] < juicy[i])
			{
				if (juicy[i] <= arr[mid + 1]) {printf("%d\n", mid + 2);break;}
				else lower = mid + 1;
			}
			else
			{
				if (mid == 0) {printf("%d\n", mid + 1); break;}
				if (juicy[i] > arr[mid - 1]){printf("%d\n", mid + 1);break;}
				else upper = mid;
			}
		}
	}
	return 0;
}

/*
There are n benches in the Berland Central park. It is known that ai 
people are currently sitting on the i-th bench. 
Another m people are coming to the park and each of them is going to have a 
seat on some bench out of n available.
Let k be the maximum number of people sitting on one bench after 
additional m people came to the park. Calculate the minimum possible 
k and the maximum possible k.
Nobody leaves the taken seat during the whole process.
*/

int benchMain() {

	// inits
	unsigned int n = 0, m = 0, kmax = 0;
	float kmin = 0;

	// input
	cin >> n;
	cin >> m;

	int* benches = new int[n+1];

	for (int i = 0; i < n; i++) {
		cin >> benches[i];
		kmin += benches[i];
		if (benches[i] >= kmax) {
			kmax = benches[i];
		}
	}

	kmin = ceil((kmin+m)/n);
	if (kmin < kmax) { kmin = kmax; }

	cout << kmin << " " << kmax + m << endl;
		return 0;

}

/*
Allen wants to enter a fan zone that occupies a round square and has n entrances.

There already is a queue of ai people in front of the i-th entrance. 
Each entrance allows one person from its queue to enter the fan zone in one minute.

Allen uses the following strategy to enter the fan zone:

Initially he stands in the end of the queue in front of the first entrance.
Each minute, if he is not allowed into the fan zone during the minute 
(meaning he is not the first in the queue), he leaves the current queue and 
stands in the end of the queue of the next entrance 
(or the first entrance if he leaves the last entrance).
Determine the entrance through which Allen will finally enter the fan zone.
*/

int worldCupMain() {
	int n = 2, m = 0, in=0, out=0, min = INT_MAX;
	cin >> n;
	int* entrances = new int[n];
	for (int i = 1; i <= n; i++) {
		cin >> in;
		if ((in - i + n) / n < min)
		{
			min = (in - i + n) / n;
			out = i;
		}

	}
	cout << out;
	return 0;
}

/*
ABCDEF
find all (a,b,c,d,e,f) such (a*b + c)/d - e = f
*/
int binSearch(int search, int* arr, int lower, int upper) {
	int mid = (lower + upper) / 2;
	int out = 0;
	if (lower <= upper) {
		if (search == arr[mid]) {
			out = 1;
		}
		else {
			if (search < arr[mid]) {
				return binSearch(search, arr, lower, mid - 1);
			}
			else {
				return binSearch(search, arr, mid + 1, upper);
			}
		}
	}
	return out;
}

int abcdef(int n, int *arr) {

	/* reorder -> a*b+c = d*(e+f)
				 (left)	  (right)
	*/
	int bound = n * n * n + 1;
	int* left = new int[bound];;
	int* right = new int[bound];
	int m = 0;

	for (int a = 0; a < n; a++) {
		for (int b = 0; b < n; b++) {
			for (int c = 0; c < n; c++) {
				left[m++] = arr[a] * arr[b] + arr[c];
			}
		}
	}
	m = 0;
	for (int d = 0; d < n; d++) {
		if (arr[d] != 0) {
			for (int e = 0; e < n; e++) {
				for (int f = 0; f < n; f++) {
					right[m++] = arr[d] * (arr[e] + arr[f]);
				}
			}
		}
	}
	int out = -1;

	for (int i = 0; i < bound; i++) {
		for (int j = 0; j < bound; j++) {
			if (left[i] == right[j]) { out++; }
		}
	}

	return out;
}

int abcdefMain() {
	
	int n = 0; 
	cin >> n;
	int* arr = new int[n];
	for (int i = 0; i < n; i++) {
		cin >> arr[i];
	}
	int k = 100;
	int randNum = 0;
	int* test = new int[k];
	for (int i = 0; i < k; i++) {
		randNum = rand() % 30001;
		test[i] = randNum;
	}

	start = clock();
	cout << abcdef(k, test) << endl;
	endd = clock();

	double time_taken = double(endd - start) / double(CLOCKS_PER_SEC);
	cout << "Time: " << time_taken << endl;
	return 0;
}

int asFastAsPossibleMain() {
	
	double n, l, v1, v2, k;
	cin >> n;
	cin >> l;
	cin >> v1;
	cin >> v2;
	cin >> k;

	double timeLeft = l/v1;
	double lower = 0, upper = timeLeft, min = -1;
	double grupos = ceil(n/ k);

	if (n <= k) {
		cout << l/v2;
	}

	else {
		while (upper - lower > 1e-8) {

			double mid = (lower+upper)/2;
			double eps = (l-(((timeLeft-mid)*v1*v2)/(v2-v1)))/v1
				-(grupos-1)*((2*v1*v2*(timeLeft-mid))/((v2*v2)-(v1*v1)));

			if (eps > 1e-6) {
				min = mid;
				upper = mid;
			}
			else {
				lower = mid;
			}
		}
		cout << min;
	}
	return 0;
}

int main() {
	ios::sync_with_stdio(0); cin.tie(0);
	wormsMain();
	return 0;
}