//
//  main.swift
//  Candies
//
//  Created by Vitor Silva on 09/02/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
// hackerrank https://www.hackerrank.com/challenges/candies/problem

import Foundation

func candies(n: Int, arr: [Int]) -> Int {
    var foward = [Int].init(repeating: 1, count: n)
    var backward = [Int].init(repeating: 1, count: n)
    
    // Fowardsum to get upward
    for i in 1..<n {
        if arr[i] <= arr[i-1] {
        } else {
            foward[i] = foward[i-1] + 1
        }
    }
    
    // Backwardsum to get downwards
    for i in (0..<n-1).reversed() {
        if arr[i] <= arr[i+1] {
        } else {
            backward[i] = backward[i+1] + 1
        }
    }
    
    var total = 0
    
    for i in 0..<n {
        total += foward[i] > backward[i] ? foward[i] : backward[i]
    }
    
    return total
}

let file = try! String(contentsOfFile: "/Users/vitorsilva/Desktop/input01.txt")

let lines = file.split(separator: "\n")

var total = Int(lines[0])!
var arr = [Int]()

for i in 1..<lines.count {
    arr.append(Int(lines[i])!)
}

print(candies(n: total, arr: arr)) //  == 33556
