// ECE7864.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <stdlib.h>
#include <vector>

using namespace std;

int f1(int x)
{
	x = x + 1;
	return 10;
}

int f2(int& x)
{
	x = x + 1;
	return 10;
}

int f3(int *x)
{
	*x = *x + 1;
	return 10;
}


int main()
{
	int x1 = 1, x2 = 1; 
	int *x3 = new int(1);

	cout << "before execution: " << endl << "x1 = " << x1 << endl << "x2 = " << x2 << endl << "x3 = " << *x3 << endl;

	f1(x1);
	f2(x2);
	f3(x3);



	cout << endl << "after execution: " << endl << "x1 = " << x1 << endl << "x2 = " << x2 << endl << "x3 = " << *x3 << endl;

	f1(x1);
	f2(x2);
	f3(x3);

	cout << endl << "2nd execution: " << endl << "x1 = " << x1 << endl << "x2 = " << x2 << endl << "x3 = " << *x3 << endl;

	system("pause");
    return 0;
}

