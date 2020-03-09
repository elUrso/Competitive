//
//  main.swift
//  Count Triplets
//
//  Created by Vitor Silva on 08/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

import Foundation

func countTriplets(arr: [Int], r: Int) -> Int {
    var dic = [Int:[Int]]()
    for i in 0..<arr.count {
        if let _ = dic[arr[i]] {
            dic[arr[i]]
        } else {
            dic[arr[i]] = [i]
        }
    }

    var count = 0
    for i1 in 0..<arr.count {
        let v1 = arr[i1]
        let v2 = v1 * r
        let v3 = v2 * r
        if let l2 = dic[v2], let l3 = dic[v3] {
            var j3 = 0
            for i2 in l2 {
                if i2 > i1 {
                    while j3 < l3.count && l3[j3] <= i2 {
                        j3 += 1
                    }
                    if j3 < l3.count {
                        count += l3.count - j3
                    }
                }
            }
        }
    }
                
    return count
}

print(countTriplets(arr: [1, 2, 2, 4], r: 2))
