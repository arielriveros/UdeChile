#include <iostream>
#include <fstream>
#include <streambuf>
#include <sstream>
#include <chrono>
#include "kmp.cpp"
#include "bm.cpp"
using namespace std;

// Program to implement the KMP algorithm in C++

int main()
{
    string fileName, pattern;
    chrono::steady_clock::time_point begin, end;
    cout << "File name: ";
    cin >> fileName;
    ifstream t(fileName);
    stringstream buffer;
    buffer << t.rdbuf();
    string text = buffer.str();
    cout << "Pattern: ";
    cin >> pattern;

    cout << endl << "Knuth-Morris-Pratt Algorithm: " << endl;
    begin = chrono::steady_clock::now();
    KMP(text, pattern);
    end = chrono::steady_clock::now();
    cout << "KMP Time = " << chrono::duration_cast<chrono::microseconds>(end - begin).count() << " µs" << endl;
    cout << endl << "Boyer-Moore Algorithm: " << endl;
    begin = chrono::steady_clock::now();
    BM(text, pattern);
    end = chrono::steady_clock::now();
    cout << "BM Time = " << chrono::duration_cast<chrono::microseconds>(end - begin).count() << " µs" << endl;
    
    return 0;
}