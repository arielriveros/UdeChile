#include <iostream>

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

int main(){

	// inputs
	int n, m;
	int piles[n];
	int jworms[m];
	std::cin >> n;
	for (int i = 0; i < n; ++i){std::cin >> piles[i]; }
	std::cin >> m;
	for (int j = 0; j < m; ++j){std::cin >> jworms[j]; }
	std::cout << "n: " << n << "\n piles: " << *piles <<
		"\n number of juicy worms: " << m <<
		"\n position of juicy worms: " << *jworms << "\n";

	// binary search

	return 0;
}
