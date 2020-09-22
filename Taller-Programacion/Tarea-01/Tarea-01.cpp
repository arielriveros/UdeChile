#include <iostream>
#include <time.h>
#include <ctime>

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

		if (juicy == labels[mid]) { cout << mid + 1 << endl; break; }

		if (juicy < labels[mid]) {
			if (juicy > labels[mid - 1]) {
				cout << mid+1 << endl;
				break;
			}
			if (juicy == labels[mid]) { cout << mid+1 << endl; break; }
			else {
				roof = mid-1;
			}
		}

		else if (juicy > labels[mid]) {
			if (juicy < labels[mid + 1]) {
				cout << mid + 2 << endl;
				break;
			}
			if (juicy == labels[mid]) { cout << mid+1 << endl; break; }
			else {
				floor = mid+1;
			}
		}
	}
}

void wormsMain() {

	// inits

	int n = 0;
	int m = 0;
	int juicy = 0;
	int maxLabel = 0;

	// inputs

	cin >> n;
	int* piles = new int[n];
	int* labels = new int[n];

	for (int i=0; i < n; ++i) { 
		cin >> piles[i]; 
		maxLabel += piles[i];
		labels[i] = maxLabel;
	}

	cin >> m;
	for (int j = 1; j <= m; j++) { 
		cin >> juicy;
		// binary search
		wormsBS(juicy, 0, n, labels);
	}
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
	int n = 0, m = 0, kmax = 0;
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

int main() {
	worldCupMain();
}