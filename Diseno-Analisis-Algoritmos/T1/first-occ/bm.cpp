#pragma once
#include <memory>
#include <string>

class BoyerMoore
{
private:
    std::unique_ptr<int[]> right;
    std::string pattern;
public:
    BoyerMoore(const std::string& p,const int& R = 256):right(new int[R]),pattern(p)
    {
        for (int i = 0; i < R; ++i)
            right[i] = -1;
        for (int i = 0; i < p.length(); ++i)
            right[p[i]] = i;
    }
    int indexOf(const std::string& s)
    {
        int M = s.length();
        int N = pattern.length();
        int i = 0,j = N - 1;
        int skip;
        for (int i = 0; i <= M - N; i += skip)
        {
            skip = 0;
            for (j = N - 1; j >= 0; --j)
            {
                if (s[i + j] != pattern[j])
                {
                    skip = j - right[s[i + j]];
                    if (skip < 1) skip = 1;
                    break;
                }
            }
            if (skip == 0) return i;
        }
        return M;
    }
};

using namespace std;

void BM(string text, string pattern)
{
    BoyerMoore bm(pattern);
    cout << bm.indexOf(text) << endl;
}