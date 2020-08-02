//
//  main.swift
//  Min Max Riddle
//
//  Created by Vitor Silva on 27/07/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  hr: https://www.hackerrank.com/challenges/min-max-riddle/problem
//


import Foundation

func riddle(arr: [Int]) -> [Int] {
    var stack = [Int]()
    // find max length of left window
    var left = [Int: Int]()
    for i in 0..<arr.count {
        if stack.count == 0 {
            stack.append(i)
        } else {
            while stack.count > 0 && arr[stack.last!] > arr[i]{
                let topIndex = stack.removeLast()
                left[topIndex] = i - topIndex
            }
            stack.append(i)
        }
    }
    // empty stack of left window
    let leftI = arr.count
    while stack.count > 0 {
        let topIndex = stack.removeLast()
        left[topIndex] = leftI - topIndex
    }
    
    // find max length of right window
    var right = [Int: Int]()
    let offset = arr.count - 1
    for i in 0..<arr.count {
        if stack.count == 0 {
            stack.append(i)
        } else {
            while stack.count > 0 && arr[offset - stack.last!] > arr[offset - i]{
                let topIndex = stack.removeLast()
                right[offset - topIndex] = i - topIndex
            }
            stack.append(i)
        }
    }
    
    // empty stack of right window
    let rightI = arr.count
    while stack.count > 0 {
        let topIndex = stack.removeLast()
        right[offset - topIndex] = rightI - topIndex
    }
    
    // combine results
    var combine = [Int:Int]()
    for i in 0..<arr.count {
        combine[i] = left[i]! + right[i]! - 1
    }
    
    
    
    // map inverse keeping maximum
    var inverse = [Int:Int]()
    for i in 0..<arr.count {
        if let value = inverse[combine[i]!] {
            if arr[i] > value {
                inverse[combine[i]!] = arr[i]
            }
        } else {
            inverse[combine[i]!] = arr[i]
        }
    }
    
    var tempMax = 0
    var reversedAnswer = [Int]()
    for i in (1...arr.count).reversed() {
        if let value = inverse[i], value > tempMax{
            tempMax = value
        }
        reversedAnswer.append(tempMax)
    }
    return reversedAnswer.reversed()
}

print(riddle(arr: [11, 2, 3, 14, 5, 2, 11, 12]))
