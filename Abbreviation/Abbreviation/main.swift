//
//  main.swift
//  Abbreviation
//
//  Created by Vitor Silva on 04/02/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  HackerRank: https://www.hackerrank.com/challenges/abbr/problem

import Foundation

// Complete the abbreviation function below.
func abbreviation(a: String, b: String) -> Bool {
    let aV: [UInt8] = Array(a.utf8)
    let bV: [UInt8] = Array(b.utf8)
    var matrix = [[Bool]](repeating: [Bool](repeating: false, count: aV.count + 1), count: bV.count + 1)
    
    matrix[0] = [Bool](repeating: true, count: aV.count)
    
    for i in 1...bV.count {
        for j in 1...aV.count {
            if bV[i-1] == aV[j-1] {
                matrix[i][j] = matrix[i-1][j-1]
            } else if aV[j-1] == bV[i-1] + 32 {
                matrix[i][j] = matrix[i-1][j-1] || matrix[i][j-1]
            } else if aV[j-1] > 96 {
                matrix[i][j] = matrix[i][j-1]
            }
        }
    }
    
    for i in (1...aV.count).reversed() {
        if matrix[bV.count][i] { return true }
        if aV[i-1] < 97 { return false }
    }
    
    return false
}

print(abbreviation(a: "beFgH", b: "EFH"))

/*
let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let q = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

for qItr in 1...q {
    guard let a = readLine() else { fatalError("Bad input") }

    guard let b = readLine() else { fatalError("Bad input") }

    let result = abbreviation(a: a, b: b)

    fileHandle.write(result.data(using: .utf8)!)
    fileHandle.write("\n".data(using: .utf8)!)
}

enum i, c, x
    d a B c d \0
  A i c x x x
  B x x c i i
  C x x x c i
 \0 x x x x i c

*/
