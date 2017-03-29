// Sortings.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <vector>
#include <stdlib.h>

using namespace std;

void insert_sort(vector<int>& nums)
{
	// insert sort
	// O(n^2)
	if (nums.size()<2) return;
	for (int i = 1; i < nums.size(); ++i)
	{
		int key = nums[i];
		int c = i - 1;
		while (c >= 0 && nums[c]>key)
		{
			nums[c + 1] = nums[c];
			c--;
		}
		nums[c + 1] = key;
	}
}

void merge(vector<int>& nums, int p, int q, int r)
{
	vector<int> tmp(r-p+1,0);
	int start1 = q;
	int start2 = r;
	int put = tmp.size() - 1;
	while (put>=0)
	{
		if (start1 < p) 
			tmp[put--] = nums[start2--];
		else if (start2 < q + 1) tmp[put--] = nums[start1--];
		else {
			if(nums[start1]>nums[start2]) tmp[put--] = nums[start1--];
			else tmp[put--] = nums[start2--];
		}
	}
	for (int i = 0; i < tmp.size(); ++i) 
		nums[p + i] = tmp[i];
}

void merge_sort(vector<int>& nums, int p, int r)
{
	if (p < r)
	{
		int q = (p + r) / 2;
		merge_sort(nums, p, q);
		merge_sort(nums, q + 1, r);
		merge(nums, p, q, r);
	}
}

int partition(vector<int> &nums, int p, int r)
{
	int x = nums[r];
	int i = p - 1;
	for (int j = p; j < r; ++j)
	{
		if (nums[j] <= x)
		{
			swap(nums[++i], nums[j]);
		}
	}
	swap(nums[++i], nums[r]);
	return i;
}

void quick_sort(vector<int> &nums, int p, int r)
{
	if (p < r)
	{
		int q = partition(nums, p, r);
		quick_sort(nums, p, q - 1); 
		quick_sort(nums, q + 1, r);
	}
}



int main()
{
	vector<int> test1 = { 1,5,32,6,4,2,3,5,6,7,43,23,23,432,4,234,23,4,234,23,4,234,234,23,4,234 };
	insert_sort(test1);

	vector<int> test2 = { 1,5,32,6,4,2,3,5,6,7,43,23,23,432,4,234,23,4,234,23,4,234,234,23,4,234 };
	merge_sort(test2, 0, test2.size() - 1);

	vector<int> test3 = { 1,5,32,6,4,2,3,5,6,7,43,23,23,432,4,234,23,4,234,23,4,234,234,23,4,234 };
	quick_sort(test3, 0, test2.size() - 1);

	system("pause");
    return 0;
}

