//
//  main.swift
//  Longest Palindromic Substring
//
//  Created by Vitor Silva on 08/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import Foundation

func longestPalindrome(_ s: String) -> String {
    let arr = Array(s.utf8)
    var m = 0 // max size
    var im = -1
    // longestPalindrome using n^2 complexity
    for i in 0..<arr.count {
        // odd
        var c = 0
        while i+c < arr.count && i-c > -1 {
            if arr[i+c] == arr[i-c] {
                c += 1
            } else {
                break
            }
        }
        if c > 0 {
            let local = (c-1)*2 + 1
            if local > m {
                m = local
                im = i-c+1
            }
        }
        // even
        c = 0
        while i+c+1 < arr.count && i-c > -1 {
            if arr[i+c+1] == arr[i-c] {
                c += 1
            } else {
                break
            }
        }
        if c > 0 {
            let local = (c)*2
            if local > m {
                m = local
                im = i-c+1
            }
        }
    }
    var sub = [UInt8]()
    for i in im..<im+m {
        sub.append(arr[i])
    }
    return String(bytes: sub, encoding: .utf8)!
}

print(longestPalindrome("cbbd"))
