/* https://cppsecrets.com/users/100741121141051219710912197115104485164103109971051084699111109/Boyer-Moore-Algorithm-for-Pattern-Searching.php */

#include<iostream>
using namespace std;

void fullSuffixMatch(int shiftArr[], int borderArr[], string pattern) {
   int n = pattern.size();       //find length of pattern
   int i = n;
   int j = n+1;
   borderArr[i] = j;

   while(i > 0) {
      //search right when (i-1)th and (j-1)th item are not same
      while(j <= n && pattern[i-1] != pattern[j-1] ) {
         if(shiftArr[j] == 0)
            shiftArr[j] = j-i;     //shift pattern from i to j
         j = borderArr[j];       //update border
      }
      i--;
      j--;
      borderArr[i] = j;
   }  
}

void partialSuffixMatch(int shiftArr[], int borderArr[], string pattern) {
   int n = pattern.size();    //find length of pattern
   int j;
   j = borderArr[0];

   for(int i = 0; i<n; i++) {
      if(shiftArr[i] == 0)
         shiftArr[i] = j;        //when shift is 0, set shift to border value
         if(i == j)
            j = borderArr[j];    //update border value
   }
}

void searchPattern(string mainString, string pattern, int array[], int *index) {
   int patLen = pattern.size();
   int strLen = mainString.size();
   int borderArray[patLen+1];
   int shiftArray[patLen + 1];

   for(int i = 0; i<=patLen; i++) {
      shiftArray[i] = 0;     //set all shift array to 0
   }

   fullSuffixMatch(shiftArray, borderArray, pattern);
   partialSuffixMatch(shiftArray, borderArray, pattern);
   int shift = 0;

   while(shift <= (strLen - patLen)) {
      int j = patLen - 1;
      while(j >= 0 && pattern[j] == mainString[shift+j]) {
         j--;         //reduce j when pattern and main string character is matching
      }

      if(j < 0) {
         (*index)++;
         array[(*index)] = shift;
         shift += shiftArray[0];
      }else {
          shift += shiftArray[j+1];
      }
   }
}

void BM(string mainString, string pattern) {
   int locArray[mainString.size()];
   int index = -1;
   searchPattern(mainString, pattern, locArray, &index);
   for(int i = 0; i <= index; i++) {
      cout << "Pattern found at position: " << locArray[i]<<endl;
    }
}