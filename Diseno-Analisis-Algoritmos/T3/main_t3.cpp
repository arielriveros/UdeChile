#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

void createData(int N, string fileName){
    ofstream File(fileName + ".txt");
    long long v1 = 0;
    for (int i=0;i<N;i++){
        v1 += rand() % 10;
        File <<  v1;
        File << "\n";
    }
    File.close();
}

int binarySearch(int arr[], int l, int r, int x){
    if (r >= l) {
        int mid = l + (r - l) / 2;
        if (arr[mid] == x)
            return mid;
        if (arr[mid] > x)
            return binarySearch(arr, l, mid - 1, x);
        return binarySearch(arr, mid + 1, r, x);
    }
    return -1;
}

int main()
{
    int arr[] = { 2, 3, 4, 10, 40 };
    int x = 10;
    int n = sizeof(arr) / sizeof(arr[0]);
    int result = binarySearch(arr, 0, n - 1, x);
    (result == -1) ? cout << "Element is not present in array"
                   : cout << "Element is present at index " << result;
    return 0;
}

