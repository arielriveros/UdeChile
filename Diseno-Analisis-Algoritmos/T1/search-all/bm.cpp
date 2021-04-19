#include <vector>
#include <string>
using namespace std;


static int Max(int a, int b) {
	return a >= b ? a : b;
}
static void BadCharHeuristic(string str, int size, int* badChar) {
	int i;
	for (i = 0; i < 256; i++){
		badChar[i] = -1;
	}
	for (i = 0; i < size; i++){
		badChar[(int)str[i]] = i;
	}
}
static vector<int> SearchString(string str, string pat) {
	vector<int> retVal;
	int m = pat.length();
	int n = str.length();
	int* badChar = new int[256];
	BadCharHeuristic(pat, m, badChar);
	int s = 0;
	while (s <= (n - m)){
		int j = m - 1;
		while (j >= 0 && pat[j] == str[s + j])
			--j;
		if (j < 0)
		{
			retVal.push_back(s);
			s += (s + m < n) ? m - badChar[str[s + m]] : 1;
		}else{
			s += Max(1, j - badChar[str[s + j]]);
		}
	}
	delete[] badChar;
	return retVal;
}

void BM(string text, string pattern){
   vector<int> value = SearchString(text, pattern);
   for(int i : value) {
      cout << "Pattern found at position: " << i << endl;
   }
}