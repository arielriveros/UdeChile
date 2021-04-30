/* Polycarpus has a ribbon, its length is n. He wants to cut the ribbon in a way that fulfils the following two conditions:
After the cutting each ribbon piece should have length a, b or c.
After the cutting the number of ribbon pieces should be maximum.
Help Polycarpus and find the number of ribbon pieces after the required cutting. */

#include <iostream>
#include <climits>

int main(){
    int n, a, b, c;
    std::cin >> n >> a >> b >> c; 
    int len = n + 1;
    int sum[len];
    std::fill(sum, sum+len, INT_MIN);
    sum[0] = 0;
    for(int i=1; i<=n; i++)
    {
        if(i - a >= 0){
                sum[i] = sum[i-a] + 1;
        }
        if(i - b >= 0 && sum[i-b] + 1 > sum[i]){
                sum[i] = sum[i-b] + 1;
        }
        if(i - c >= 0 && sum[i-c] + 1 > sum[i]){
                sum[i] = sum[i-c] + 1;
        }
    }
    std::cout << sum[n] << std::endl;
    return 0;
}