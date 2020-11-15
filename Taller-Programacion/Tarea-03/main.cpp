#include <iostream>
#include <vector>
using namespace std;

template<class T>
struct FenwickTree{
    vector<T>FT;
    int n;

    FenwickTree(int n) : n(n){ FT.resize(n + 1);
    }

    T query(int pos){
        pos ++;
        T sum = 0;
        while(pos > 0){
            sum += FT[pos];
            pos -= (pos & (-pos));
        }
        return sum;
    }

    T query(int l, int r){
        return query(r) - query(l - 1);
    }

    void addUpdate(int pos, T val){
        pos ++;
        while(pos <= n){
            FT[pos] += val;
            pos += (pos & (-pos));
        }
    }

    void setUpdate(int pos, T val){
        addUpdate(pos, val - query(pos, pos));
    }
};

int mainPotenc(){
    ios::sync_with_stdio(0); cin.tie(0);
    int t;
    cin >> t;
    int k = 0;
    while (t){
        k ++;
        FenwickTree<int> FT(t);
        for(int i = 0; i<t;i++){
            int n; cin >> n;
            FT.setUpdate(i, n);
        }
        string s;
        while(cin>>s, s!="END"){
            if(s[0]=='M'){
                int x, y;
                cin >> x >> y;
                cout << FT.query(x-1,y-1) << "\n";
            }
            if(s[0]=='S'){
                int x, r;
                cin >> x >> r;
                FT.setUpdate(x-1,r);
            }
        }
        cin >> t;
    }
    return 0;
}


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


int query(int index, int *fenwick)
{
    ++index;
    int sum = 0;
    while (index>0)
    {
        sum += fenwick[index];
        index -= index & (-index);
    }
    return sum;
}
void update(int index, int *fenwick, int n, int val)
{
    ++index;
    while (index <= n)
    {
        fenwick[index] += val;
        index += index & (-index);
    }
}
int *constructFenwick(int arr[], int n)
{
    int *fenwick = new int[n+1];
    for (int i=1; i<=n; i++)
        fenwick[i] = 0;

    for (int i=0; i<n; i++)
        update(i, fenwick, n, arr[i]);
    return fenwick;
}
int mainFenwick() {
    int n, q, l_i, r_x;
    char op;
    cin >> n;
    int *array = new int[n];
    for (int i = 0; i < n; i++) {
        cin >> array[i];
    }
    int *arr = constructFenwick(array,n);
    cin >> q;
    int *ans = new int[q];
    int queries = 0;
    for (int j = 0; j < q;j++) {
        cin >> op;
        cin >> l_i;
        cin >> r_x;
        if (op == 'q') {
            ans[queries] = query(r_x-1, arr) - query(l_i-2, arr);
            queries++;
        }else {
            update(l_i-1,arr,n,r_x);
            continue;
        }
    }
    for(int m = 0; m < queries-1; m++){
        cout << ans[m] << "\n";
    }
    cout << ans[queries-1];
    return 0;
}

int main() {
    mainPotenc();
    return 0;
}