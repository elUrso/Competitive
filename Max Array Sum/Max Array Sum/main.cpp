//
//  main.cpp
//  Max Array Sum
//
//  Created by Vitor Silva on 16/08/19.
//  Copyright © 2019 Vitor Silva. All rights reserved.
//
//  Hackerrank: https://www.hackerrank.com/challenges/max-array-sum/problem

#include <iostream>
#include <vector>

inline int number(void);
int maxNonConsecutiveSum(std::vector<int>);

int main(int argc, const char * argv[]) {
    
    int size;
    std::cin >> size;
    
    std::vector<int> arr(size);
    
    for(int i = 0; i < size; i++) arr.push_back(number());
    
    std::cout << maxNonConsecutiveSum(arr) << std::endl;
    
    return 0;
}

inline int number() {
    int tmp;
    std::cin >> tmp;
    return tmp;
}


/* Given an array, find the max sum of non consecutive elements
 * Solvable using DP with O(n)
 * for elements after index 1 the partial max sum is:
 * either itself plus max of i-2
 * itself
 * or the currentMax
 */
int maxNonConsecutiveSum(std::vector<int> arr) {
    if(arr.size() == 0) return 0;
    if(arr.size() == 1) return arr[0];
    if(arr.size() == 2) return std::max(arr[0], arr[1]);
    
    int currentMax = std::max(arr[0], arr[1]);
    int beforeBeforeBefore = 0;
    int beforeBeforeMax = arr[0];
    int beforeMax = arr[1];
    
    for(int i = 2; i < arr.size(); i++) {
        int current = arr[i];
        if(current > currentMax) currentMax = current;
        if(beforeBeforeMax + current > currentMax) currentMax = beforeBeforeMax + current;
        if(beforeBeforeBefore + current > currentMax) currentMax = beforeBeforeBefore + current;
        beforeBeforeBefore = std::max(beforeBeforeMax, beforeBeforeBefore);
        beforeBeforeMax = beforeMax;
        beforeMax = currentMax;
    }
    
    return currentMax;
}
