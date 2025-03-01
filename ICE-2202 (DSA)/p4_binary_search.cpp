#include <bits/stdc++.h>
using namespace std;

int binarySearch(vector<int> arr, int size, int target)
{
     int left = 0;
     int right = size - 1;

     while (left <= right)
     {
          int mid = left + (right - left) / 2;

          if (arr[mid] == target)
          {
               return mid; // Target found at index mid
          }
          else if (arr[mid] < target)
          {
               left = mid + 1; // Search in the right half
          }
          else
          {
               right = mid - 1; // Search in the left half
          }
     }
     return -1; // Target not found
}

int main()
{
     int n;
     cin >> n;
     vector<int> arr(n);
     for (int i = 0; i < n; i++)
     {
          cin >> arr[i];
     }
     int target;
     cin >> target;
     sort(arr.begin(), arr.end());
     int result = binarySearch(arr, n, target);

     if (result != -1)
     {
          cout << "Element found at index " << result << endl;
     }
     else
     {
          cout << "Element not found in the array" << endl;
     }

     return 0;
}
