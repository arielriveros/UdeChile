#include <iostream>
using namespace std;

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


int main() {

	wormsMain();
	return 0;
}
