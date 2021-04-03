#include <iostream>

/* Polycarpus loves hamburgers very much. He especially adores the 
hamburgers he makes with his own hands. Polycarpus thinks that there are only 
three decent ingredients to make hamburgers from: a bread, sausage and cheese. 
He writes down the recipe of his favorite "Le Hamburger de Polycarpus" as a string 
of letters 'B' (bread), 'S' (sausage) и 'C' (cheese). The ingredients in the recipe 
go from bottom to top, for example, recipe "ВSCBS" represents the hamburger 
where the ingredients go from bottom to top as bread, sausage, cheese, bread and sausage again.

Polycarpus has nb pieces of bread, ns pieces of sausage and nc pieces of cheese in the kitchen. 
Besides, the shop nearby has all three ingredients, the prices are pb rubles 
for a piece of bread, ps for a piece of sausage and pc for a piece of cheese.

Polycarpus has r rubles and he is ready to shop on them. What maximum number 
of hamburgers can he cook? You can assume that Polycarpus cannot break or slice 
any of the pieces of bread, sausage or cheese. Besides, the shop has an unlimited 
number of pieces of each ingredient. */


long long B=0,S=0,C=0,a,b,c,pa,pb,pc,m;
bool check(long long x){
	long long na = x*B-a, nb = x*S-b, nc = x*C-c, mo = 0;
	if(na>0) mo+=na*pa; if(nb>0) mo+=nb*pb; if(nc>0) mo+=nc*pc;
	return m>=mo;
}
int main(){
	std::string str; 
    std::cin >> str >> a >> b >> c >> pa >> pb >> pc >> m;
	for(int i=0;i<str.length();i++){
        switch (str[i]){
        case 'B': B++; break;
        case 'S': S++; break;
        default: C++; break;
        }
	} 
	long long left = 0, right = 1e13, mid, output = 0;
	while(left<=right){
		long long mid=(left + right) >> 1;
		if(check(mid)){
			output = mid;
			left = mid+1;
		}
		else right=mid-1;
	}
	std::cout << output << std::endl;
	return 0;
}