//
//  main.swift
//  Maximum Xor
//
//  Created by Vitor Silva on 23/02/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
// HackerRank: https://www.hackerrank.com/challenges/maximum-xor/problem

import Foundation

extension Int {
    var as32Bits: [Int] {
        var tmp = self
        var ret = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        for i in (0..<32).reversed() {
            ret[i] = tmp % 2
            tmp /= 2
        }
        return ret
    }

    var as32BitsNegated: [Int] {
        var tmp = self
        var ret = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        for i in (0..<32).reversed() {
            ret[i] = (tmp % 2) == 0 ? 1 : 0
            tmp /= 2
        }
        return ret
    }
}

class Trie {
    class Node {
        var zero: Node? = nil
        var one: Node? = nil
    }
    
    let root = Node()
    
    init(of arr: [Int]) {
        //Build trie
        for item in arr { insert(item) }
    }

    func insert(_ number: Int) {
        var sentinel = root
        for n in number.as32Bits {
            if n == 0 {
                if let zero = sentinel.zero {
                    sentinel = zero
                } else {
                    sentinel.zero = Node()
                    sentinel = sentinel.zero!
                }
            } else {
                if let one = sentinel.one {
                    sentinel = one
                } else {
                    sentinel.one = Node()
                    sentinel = sentinel.one!
                }
            }
        }
    }

    func query(_ closest: [Int]) -> Int {
        return recursiveQuery(closest, root, 0)
    }

    func recursiveQuery(_ number: [Int], _ node: Node, _ deep: Int) -> Int {
        if deep == 32 { return 0 }
        let n = number[deep]
        let m = n == 0 ? 1 : 0
        let first: Node? = n == 0 ? node.zero: node.one
        let second: Node? = n == 1 ? node.zero: node.one
        if let first = first {
            return (n << (31 - deep)) + recursiveQuery(number, first, deep + 1)
        } else {
            return (m << (31 - deep)) + recursiveQuery(number, second!, deep + 1)
        }
    }
}

func maxXor(arr: [Int], queries: [Int]) -> [Int] {
    // solve here
    let trie = Trie(of: arr);
    return queries.map{ q in trie.query(q.as32BitsNegated) ^ q}
}

//maxXor(arr: [3, 7, 15, 10], queries: [3])

let trie = Trie(of: [3,7,15,10])

print(trie.query(3.as32BitsNegated))

