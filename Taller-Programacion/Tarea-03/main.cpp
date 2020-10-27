
/* Fenwick Trees
Mr. Fenwick has an array a with many integers, and his children love to do operations on the
array with their father. The operations can be a query or an update.
For each fenwick the children say two indices l and r , and their father answers back with the sum
of the elements from indices l to r (both included).
When there is an update, the children say an index i and a value x , and Fenwick will add x to
ai (so the new value of ai  is ai + x ).
Because indexing the array from zero is too obscure for children, all indices start from 1.
Fenwick is now too busy to play games, so he needs your help with a program that plays with his
children for him, and he gave you an input/output specification.
 */

#include <iostream>
using namespace std;

int query (int index, const int *array) {
    int sum = 0;
    while(index != 0) {
        sum += array[index-1];
        index -= -index != 0;
    }
    return sum;
}
int *update (int index, int n, int* array, int x){
    while (index <= n)
    {
        index += -index != 0;
    }
    array[index-1] += x;
    return array;
}
int main() {
    int n, q, l_i, r_x;
    char op;
    cin >> n;
    int *arr = new int[n];
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    cin >> q;
    int *ans = new int[q];
    int queries = 0;
    for (int j = 0; j < q;j++) {
        cin >> op;
        cin >> l_i;
        cin >> r_x;
        if (op == 'q') {
            ans[queries] = query(r_x, arr) - query(l_i - 1, arr);
            queries++;
        }else {
            arr[l_i-1] += r_x;
            continue;
        }
    }
    for(int m = 0; m < queries; m++){
        cout << ans[m] << endl;
    }
    return 0;
}