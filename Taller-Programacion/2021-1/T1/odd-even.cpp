#include <iostream>

/* Ashish has an array a of size n.
A subsequence of a is defined as a sequence that can be obtained from a by deleting some elements (possibly none), 
without changing the order of the remaining elements.
Consider a subsequence s of a. He defines the cost of s as the minimum between:
The maximum among all elements at odd indices of s.
The maximum among all elements at even indices of s.
Note that the index of an element is its index in s, rather than its index in a. 
The positions are numbered from 1. So, the cost of s is equal to min(max(s1,s3,s5,…),max(s2,s4,s6,…)).

For example, the cost of {7,5,6} is min(max(7,6),max(5))=min(7,5)=5.

Help him find the minimum cost of a subsequence of size k. */

int n; // Array size
int k; // Subsequence size
const long bound=200001; int seq[bound]; // Sequence so that 2 <= k <= n <= 2*10^5

bool condition(int m, bool cond_2)
{
    int counter = 0;
    for(int i=1; i<=n; i++)
    if(cond_2 || m >= seq[i])
    {
        counter++;
        cond_2 = !cond_2;
    }
    return k <= counter;
}
int maigan()
{
    std::cin >> n >> k;
    for (int i = 1; i <= n; i++){
        std::cin >> seq[i];
    }   
    int left = 1, right = 1e9, output;
    while (right >= left){
        int mid= left + right >> 1;
        if (condition(mid,1) || condition(mid,0)){
            output=mid;
            right = mid-1;
        }else {
            left = mid+1;
        }
    }
    std::cout << output<< std::endl;
    return 0;
}