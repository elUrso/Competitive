//
//  main.cpp
//  Reverse Shuffle Merge
//
//  Created by Vitor Silva on 28/08/19.
//  Copyright © 2019 Vitor Silva. All rights reserved.
//
// HackerRank: https://www.hackerrank.com/challenges/reverse-shuffle-merge/problem

#include <iostream>
#define AZ ('z' - 'a' + 1) // Number of letters in [a,z]
#define last(s) (s[s.size() - 1])
std::string reverseShuffleMerge(std::string s){
    int frequencyCount[AZ] = {}; // Stores the frequency of each character in the string
    int requiredCount[AZ] = {}; // Stores the frequency of characters required to complete the solution string
    int usedCount[AZ] = {}; // Stores the frequency of characters used in the solution string
    int availableCount[AZ] = {}; // Stores the ammount of usable charactes in the string (could use frequency sort, but it exists for the pourpose of readability)

    std::string out("");
    
    // frequency count
    for(std::string::iterator i = s.begin(); i != s.end() ; i++) {
        char c = *i - 'a';
        frequencyCount[c]++;
        availableCount[c]++;
    }
    
    
    // required count
    for (int i = 0; i <= AZ; i++) {
        requiredCount[i] = frequencyCount[i] / 2;
    }
    
    
    // since the source string is stored in the reverse order inside the string s
    for (std::string::reverse_iterator i = s.rbegin(); i != s.rend(); i++) {
        std::cout << "Reading: " << *i << std::endl;
        // Check if the character is required
        if (requiredCount[*i - 'a']) {
            // check were to insert it
            if (out.size() > 0) {
                // remove elements that are lexicographically bigger than the current while still possible to add than later
                while (out.size() > 0 && last(out) > *i) {
                    // while can remove the last one remove
                    char end = last(out);
                    if (availableCount[end - 'a'] > requiredCount[end - 'a']) {
                        std::cout << "poped " << end << std::endl;
                        requiredCount[end - 'a']++;
                        usedCount[end - 'a']--;
                        out.pop_back();
                    } else {
                        break;
                    }
                }
                // insert the required element
                out.push_back(*i);
                usedCount[*i - 'a']++;
                requiredCount[*i - 'a']--;
                availableCount[*i - 'a']--;
                std::cout << "inserted " << last(out) << std::endl;
                std::cout << out << std::endl;
            }
            // if the out is empty just insert it!
            else {
                out.push_back(*i);
                usedCount[*i - 'a']++;
                requiredCount[*i - 'a']--;
                availableCount[*i - 'a']--;
                std::cout << "inserted " << last(out) << std::endl;
                std::cout << out << std::endl;
            }
            // if is not required, just remove the unused element
        } else {
            availableCount[*i - 'a']--;
        }
    }
    
    return out;
}

int main()
{

    std::string s;
    std::getline(std::cin, s);

    std::string result = reverseShuffleMerge(s);

    std::cout << result << "\n";

    return 0;
}
