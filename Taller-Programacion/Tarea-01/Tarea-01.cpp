#include <iostream>
#include <algorithm>
#include <cmath>
#include <time.h>
#include <ctime>
#include <climits>

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

void wormsBS(int juicy, int floor, int roof, int* labels) {
	while (floor <= roof) {
		int mid = (floor + roof) / 2;
		if (juicy <= labels[mid]) {
			if (juicy > labels[mid - 1] || juicy == labels[mid]) {
				cout << mid + 1 << endl;
				break;
			}
			else {
				roof = mid;
			}
		}
		else if (juicy > labels[mid]) {
			if (juicy < labels[mid + 1] || juicy == labels[mid+1]) {
				cout << mid + 2 << endl;
				break;
			}
			else {
				floor = mid;
			}
		}
	}
}

int wormsMain() {
	unsigned int n = 0, m = 0, juicy = 0, maxLabel = 0;
	cin >> n;
	int* piles = new int[n];
	int* labels = new int[n];
	for (int i = 0; i < n; ++i) {
		cin >> piles[i];
		maxLabel += piles[i];
		labels[i] = maxLabel;
	}
	cin >> m;
	for (int j = 1; j <= m; j++) {
		cin >> juicy;
		wormsBS(juicy, 0, n, labels);
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

int main() {
	ios::sync_with_stdio(0); cin.tie(0);
	abcdefMain();
	return 0;
}