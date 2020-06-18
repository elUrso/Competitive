//
//  main.swift
//  Simple Text Editor
//
//  Created by Vitor Silva on 17/06/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  hh: https://www.hackerrank.com/challenges/simple-text-editor/problem

import Foundation

let commands = Int(readLine(strippingNewline: true)!)!
var state = [""]

for _ in 0..<commands {
    let input = readLine(strippingNewline: true)!.split(separator: " ")
    let command = Int(input[0]) ?? 0
    switch command {
    case 1:
        state.append(state.last! + String(input[1]))
    case 2:
        let last = state.last!
        state.append(String(last.dropLast(Int(input[1])!)))
    case 3:
        let index = Int(String(input[1])) ?? 0
        print(Character(UnicodeScalar(Array(state.last!.utf8)[index-1])))
    case 4:
        if let _ = state.popLast(), state.count == 0 {
            state.append("")
        }
    default:
        print("Something whent wrong")
    }
}
