/* Code by hsinewu: https://gist.github.com/hsinewu/44a1ce38a1baf47893922e3f54807713 */

/*
#include <iostream>
#include <stdlib.h>
#include <string>
using namespace std;
 
 int find_substring(string str, string pattern) {
	// Step 0. Should not be empty string
	if( str.size() == 0 || pattern.size() == 0)
		return -1;
	// Step 1. Compute failure function
	int failure[pattern.size()];
	fill( failure, failure+pattern.size(), -1);
	for(int r=1, l=-1; r<pattern.size(); r++) {

		while( l != -1 && pattern[l+1] != pattern[r])
			l = failure[l];

		// assert( l == -1 || pattern[l+1] == pattern[r]);
		if( pattern[l+1] == pattern[r])
			failure[r] = ++l;
	}
	// Step 2. Search pattern
	int tail = -1;
	for(int i=0; i<str.size(); i++) {
		while( tail != -1 && str[i] != pattern[tail+1])
			tail = failure[tail];
		if( str[i] == pattern[tail+1])
			tail++;
		if( tail == pattern.size()-1)
			return i - tail;
	}
	return -1;
}

void KMP(string str, string pattern) {
    int index = find_substring(str, pattern);
    if(index != -1){
        cout << "Pattern found at position: " << index << endl;
    }else{
        cout << "Pattern not found: " << endl;
    }
} */

#include<iostream>
#include<string>

using namespace std;

int *pre_kmp(string pattern)
{
	int size = pattern.size();
	int *pie=new int [size];
	pie[0] = 0;
	int k=0;
	for(int i=1;i<size;i++)
	{
		while(k>0 && pattern[k] != pattern[i] )
		{
			k=pie[k-1];
		}
		if( pattern[k] == pattern[i] )
		{
			k=k+1;
		}
		pie[i]=k;
	}
	
	return pie;
}

void KMP(string text,string pattern)
{
	int* pie=pre_kmp(pattern);
	int matched_pos=0;
	for(int current=0; current< text.length(); current++)
	{
		while (matched_pos > 0 && pattern[matched_pos] != text[current] )
			matched_pos = pie[matched_pos-1];
			
		if(pattern[matched_pos] == text[current])
			matched_pos = matched_pos+1;
			
		if( matched_pos == (pattern.length()) )
		{
			cout<<"Pattern found at position "<< current - (pattern.length() -1 ) << endl;
			matched_pos = pie[matched_pos-1];
		}
	}
}