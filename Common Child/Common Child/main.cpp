//
//  main.cpp
//  Common Child
//
//  Created by Vitor Silva on 18/08/19.
//  Copyright © 2019 Vitor Silva. All rights reserved.
//
// HackerRank: https://www.hackerrank.com/challenges/common-child/problem

#include <iostream>
#include <vector>

int L[6000][6000]; // More memory

int lcs(std::string X, std::string Y, int m, int n) {
    int i, j;

    for (i=0; i<=m; i++)
    {
        for (j=0; j<=n; j++)
        {
            if (i == 0 || j == 0)
                L[i][j] = 0;
            
            else if (X[i-1] == Y[j-1])
                L[i][j] = L[i-1][j-1] + 1;
            
            else
                L[i][j] = std::max(L[i-1][j], L[i][j-1]);
        }
    }
    
    /* L[m][n] contains length of LCS for X[0..n-1] and Y[0..m-1] */
    return L[m][n];
}

// Complete the commonChild function below.
int commonChild(std::string s1, std::string s2) {
    return lcs(s1, s2, (int) s1.size(), (int) s2.size());
}

int main()
{
    std::string s1;
    std::getline(std::cin, s1);
    
    std::string s2;
    std::getline(std::cin, s2);
    
    int result = commonChild(s1, s2);
    
    std::cout << result << std::endl;
    
    return 0;
}
