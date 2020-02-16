//
//  main.swift
//  Friend Circle Queries
//
//  Created by Vitor Silva on 16/02/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  HackerRank: https://www.hackerrank.com/challenges/friend-circle-queries/problem

import Foundation

class UF {
    /// We are useing dictionaries due to the size of the set
    /// We also need to consider that the numbers of queries is smaller the the number of people
    /// Pointer to parent
    var parent: [Int:Int] = [Int:Int]()
    /// Size of the set, parent is the only one who holds a valid value
    var sizes: [Int:Int] = [Int:Int]()
    /// Keep the largest size
    var largestSet: Int = 1

    /// Lookup the parent
    /// Because of the dictonary structure used, the root of the set
    /// has a value of nil, this is why we use `?? node`
    func parent(of node: Int) -> Int {
        if (parent[node] ?? node) == node { return node }
        else { return parent(of: parent[node]!)}
    }

    func unite(_ a: Int, _ b: Int) {
        /// Get parents and sizes
        let parentA = parent(of: a)
        let parentB = parent(of: b)
        let sizeA = sizes[parentA] ?? 1
        let sizeB = sizes[parentB] ?? 1
        /// The root of the new set is the root of the bigger set : )
        if parentA != parentB {
            let newSize = sizeA + sizeB
            if sizeA > sizeB {
                parent[parentB] = parentA
                sizes[parentA] = newSize
            } else {
                parent[parentA] = parentB
                sizes[parentB] = newSize
            }
            /// Update the largestSet size if needed
            if largestSet < newSize {
                largestSet = newSize
            }
        }
        
    }

    init() {
        print("ready")
    }
}

// Complete the maxCircle function below.
func maxCircle(queries: [[Int]]) -> [Int] {
    // Create the UF
    let uf = UF()
    
    // Papare the output
    var largestGroup = [Int].init(repeating: 1, count: queries.count)
    
    // Process each query
    var counter = 0
    for query in queries {
        uf.unite(query[0], query[1])
        largestGroup[counter] = uf.largestSet
        counter += 1
    }
    
    // Jobs done
    return largestGroup
}

/*
let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let q = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

let queries: [[Int]] = AnyIterator{ readLine() }.prefix(q).map {
    let queriesRow: [Int] = $0.split(separator: " ").map {
        if let queriesItem = Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) {
            return queriesItem
        } else { fatalError("Bad input") }
    }

    guard queriesRow.count == 2 else { fatalError("Bad input") }

    return queriesRow
}

guard queries.count == q else { fatalError("Bad input") }

let ans = maxCircle(queries: queries)

fileHandle.write(ans.map{ String($0) }.joined(separator: "\n").data(using: .utf8)!)
fileHandle.write("\n".data(using: .utf8)!)
*/
