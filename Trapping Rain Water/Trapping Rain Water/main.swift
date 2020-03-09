//
//  main.swift
//  Trapping Rain Water
//
//  Created by Vitor Silva on 08/03/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

/*
 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
 
 4
 3                     XXX
 2         XXX.........XXXXXX...XXX
 1   XXX...XXXXXX...XXXXXXXXXXXXXXXXXX
    0  1  2  3  4  5  6  7  8  9 10 11
[   0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]

 The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

 Example:

 Input: [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6
 */

import Foundation

struct Cliff {
    let index: Int
    let height: Int
}

func trap(_ height: [Int]) -> [Cliff] {
    var cliff = [Cliff]()
    
    // Compute local cliffs
    if height[0] >= height[1] {
        cliff.append(Cliff(index: 0, height: height[0]))
    }
    for i in 1..<height.count-1 {
        if height[i] > height[i-1] && height[i] >= height[i+1] {
            cliff.append(Cliff(index: i, height: height[i]))
        }
    }
    if height[height.count - 1] >= height[height.count - 2] {
        cliff.append(Cliff(index: height.count - 1, height: height[height.count - 1]))
    }
    
    // Reduce to segments using tow pointers
    var left = 0
    var right = cliff.count - 1
    var leftWater = 0
    var rightWater = 0
    var sum = 0
    
    while left < right {
        if cliff[left+1].height >= cliff[left].height {
            let local = area(in: height, from: cliff[left].index, to: cliff[left+1].index)
            if local > leftWater {
                leftWater = local
            }
            sum += local
            left += 1
        } else if cliff[right-1].height >= cliff[right].height {
            let local = area(in: height, from: cliff[right-1].index, to: cliff[right].index)
            if local > rightWater {
                rightWater = local
            }
            sum += local
            right -= 1
        } else if left < right - 1 && cliff[left+1].height < cliff[right].height{
            cliff[left + 1] = cliff[left]
            left += 1
        } else if left + 1 < right {
            cliff[right - 1] = cliff[right]
            right -= 1
        } else {
            let local = area(in: height, from: cliff[left].index, to: cliff[right].index)
            if local > rightWater {
                rightWater = local
            }
            sum += local
        }
    }
    // lergest pool
    print(max(rightWater, leftWater))
    // sum
    print(sum)
    return cliff
}

func area(in height: [Int], from a: Int, to b: Int) -> Int {
    var area = 0
    let maxHeight = min(height[a], height[b])
    
    for i in a..<b {
        area += max(maxHeight - height[i], 0)
    }
    
    return area
}

//print(trap([0,1,0,2,1,0,1,3,2,1,2,1])) //6


//print(trap([5,5,1,7,1,1,5,2,7,6])) //25

print(trap([1,9,7,1,3,6,4,7,4,8,3,6,3,5,3,7])) // 39
