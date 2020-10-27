#include <iostream>
#include <cmath>
#include <stdio.h>
using namespace std;

int checkForK(int n) {
    int k = 2;
    int sum = 3;
    while (n % sum)
    {
        sum += k * 2;
        k *= 2;
    }
    int x = n / sum;
    return x;
}

int checkForKMain() {
    int t;
    cin >> t;
    int* arr = new int[t];
    for (int i = 0; i < t; i++) {
        cin >> arr[i];
    }
    for (int j = 0; j < t; j++) {
        cout << checkForK(arr[j]) << "\n";
    }

    return 0;
}

/*
int p[50];
void printArray(int* array, int m) {
    int n;
    for (int i = 0; i < m - 1; i++) { 
        n = array[i]; cout << p[n] << ' '; 
    }
    n = array[m - 1];
    cout << p[n] << endl;
}

void GenComb(int* a, int n, int m)
{
    int i, j, t;
    printArray(a, m);
    for (j = m - 1; j >= 0; j--)
        if (a[j] < n - m + j + 1) { 
            break; 
        }
    t = a[j];
    for (i = 0; i <= m - j - 1; i++) {
        a[j + i] = t + i + 1;
    }
}
void GenAllComb(int* a, int n, int m)
{
    int index;
    for (index = 0; index < m; index++) { 
        a[index] = index + 1; 
    }
    index = 0;
    while (index <= n - m)
    {
        GenComb(a, n, m);
        if (a[0] > index + 1) { 
            index++; 
        }
    }
}
int main()
{
    int n, m = 6, a[50], i;
    int first = 0;
    while (cin >> n, n)
    {
        if (first) {
            cout << endl;
            first = 1;
        }
        for (i = 1; i <= n; i++) { 
            cin >> p[i]; 
        }
        GenAllComb(a, n, m);

    }
    return 0;
}
*/

char used[50] = { 0 };
int num[50], n;
int select[7];
void dfs(int step)
{
    int i;;
    if (step == 7)
    {
        for (i = 1; i <= 6; i++)
        {
            printf("%d", select[i]);
            if (i != 6)printf(" ");
        }
        printf("\n");
    }
    else
        for (i = 1; i <= n; i++)
        {
            if (used[num[i]])continue;
            if (num[i] >= select[step - 1])
            {
                used[num[i]] = 1;
                select[step] = num[i];
                dfs(step + 1);
                used[num[i]] = 0;
            }
        }
}

int main()
{
    //freopen("in.txt","r",stdin);
    int i;
    while (scanf("%d", &n), n)
    {
        for (i = 1; i <= n; i++)
            scanf("%d", &num[i]);
        dfs(1);
        printf("\n");
    }
    return 0;
}