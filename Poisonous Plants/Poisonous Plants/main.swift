//
//  main.swift
//  Poisonous Plants
//
//  Created by Vitor Silva on 15/06/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  hr: https://www.hackerrank.com/challenges/poisonous-plants/problem

import Foundation

class Node<T> {
    let value: T
    var next: Node<T>?
    var end: Node<T>?
    var isLonely: Bool {
        get {
            return end === nil || self === end!
        }
    }
    
    init(value: T) {
        self.value = value
    }
}

// Complete the poisonousPlants function below.
func poisonousPlants(p: [Int]) -> Int {
    let root = Node(value: p[0])
    var curr: Node<Int>! = root
    var head: Node<Int>! = curr
    for i in 1..<p.count {
        let next = Node(value: p[i])
        if p[i] > curr.value {
            head.end = curr
            head = next
        }
        curr.next = next
        curr = next
    }
    head.end = curr
    
    var round = 0
    while root.end!.next != nil {
        curr = root
        while curr.end?.next != nil  {
            if curr.end!.next!.isLonely { // Next sequence is length 1
                curr.end!.next = curr.end!.next!.next
            } else if curr.end!.next!.next!.value <= curr.end!.value { // Next sequence can be merged
                let next = curr.end!.next!
                curr.end!.next = next.next
                curr.end = next.end
            } else { // Just pop head of next sequence
                curr.end!.next!.next!.end = curr.end!.next!.end
                curr.end!.next! = curr.end!.next!.next!
                curr = curr.end!.next ?? curr
            }
            
        }
        round += 1
    }
    return round
}

print(poisonousPlants(p: [3, 6, 2, 7, 5]) == 2)
print(poisonousPlants(p: [4, 3, 7, 5, 6, 4, 2]) == 3)
print(poisonousPlants(p: [6, 5, 8, 4, 7, 10, 9]) == 2)
