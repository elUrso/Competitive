//
//  main.swift
//  Making Candies
//
//  Created by Vitor Silva on 30/01/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//

// This one plays with overflow :/

import Foundation

// Complete the minimumPasses function below.
func minimumPasses(m: Int64, w: Int64, p: Int64, n: Int64) -> Int64 {
    // Solution is greedy
    
    var m: Int64 = Int64(m)
    var w: Int64 = Int64(w)
    let p: Int64 = Int64(p)
    let n: Int64 = Int64(n)
    
    var turn: Int64 = 1
    var candies: Int64 = Int64(min(Double(m) * Double(w), Double(Int.max - 1)))

    while candies < n {
        print("T\(turn): has: \(candies) m: \(m) w: \(w) to reach \(n)")
        let doNothing = ceilDiv(n - candies, m * w)
        print("Needs more \(doNothing)")
        let canBuy = candies / p
        if canBuy == 0 { // too poor :/
            let needs = ceilDiv(p - candies, m * w)
            if doNothing < needs {
                return turn + doNothing
            } else {
                turn += needs
                candies += m * w * needs
            }
        } else {
            let (m_, w_) = maximize(m, w, canBuy)
            let needs = ceilDiv(n - candies + (canBuy * p), m_ * w_)
            if doNothing < needs {
                return turn + doNothing
            } else {
                turn += 1
                candies -= canBuy * p
                candies += m_ * w_
                m = m_
                w = w_
            }
        }
    }
    
    return turn
}

func ceilDiv(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    return (lhs % rhs == 0 ? 0 : 1) + lhs / rhs
}

func maximize(_ m: Int64, _ n: Int64, _ c: Int64) -> (Int64, Int64) {
    if m <= n {
        let diff = n - m
        if c <= diff {
            return (m + c, n)
        } else {
            let left = c - diff
            return (m + diff + left/2, n + ceilDiv(left, 2))
        }
    } else {
        return maximize(n, m, c)
    }
}

print(minimumPasses(m: 5184889632, w: 5184889632, p: 10, n: 10000))
