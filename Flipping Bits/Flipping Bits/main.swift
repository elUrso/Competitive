//
//  main.swift
//  Flipping Bits
//
//  Created by Vitor Silva on 30/01/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  hackerrank: https://www.hackerrank.com/challenges/flipping-bits/

import Foundation

// Complete the flippingBits function below.
func flippingBits(n: UInt32) -> UInt32 {
    return ~n
}

let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let q = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

for qItr in 1...q {
    guard let n = UInt32((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    else { fatalError("Bad input") }

    let result = flippingBits(n: n)

    fileHandle.write(String(result).data(using: .utf8)!)
    fileHandle.write("\n".data(using: .utf8)!)
}
