//
//  main.swift
//  Largest Rectangle
//
//  Created by Vitor Silva on 16/06/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  hr: https://www.hackerrank.com/challenges/largest-rectangle/problem
//

import Foundation

func area(_ io: Int, _ ho: Int, _ ip: Int) -> Int{
    return (ip - io) * ho
}

func popUntil(_ s: inout [(i: Int, h: Int)], _ i: Int, _ h: Int, _ m: inout Int) {
    while s.count > 0 && s.last!.h > h {
        let popped = s.popLast()!
        m = max(m, area(popped.i, popped.h, i))
        let last = s.last ?? (i: -1, h: 0)
        if last.h < h {
            s.append((i: popped.i, h: h))
        }
    }
}

// Complete the largestRectangle function below.
func largestRectangle(h: [Int]) -> Int {
    var maximum = 0
    var stacks = Array<(i: Int, h: Int)>()
    for i in 0..<h.count {
        if stacks.count == 0 {
            stacks.append((i: i, h: h[i]))
        } else if stacks.last!.h == h[i] {
            // do nothing
        } else if stacks.last!.h > h[i] {
            popUntil(&stacks, i, h[i], &maximum)
            if stacks.count == 0 || (stacks.last!.h < h[i]) {
                stacks.append((i: i, h: h[i]))
            }
        } else {
            stacks.append((i: i, h: h[i]))
        }
    }
    popUntil(&stacks, h.count, 0, &maximum)
    return maximum
}

print(largestRectangle(h: [11, 11, 10, 10, 10]))


