//
//  main.swift
//  Inserting a Node Into a Sorted Doubly Linked List
//
//  Created by Vitor Silva on 30/01/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
// Hackerrank: https://www.hackerrank.com/challenges/insert-a-node-into-a-sorted-doubly-linked-list

import Foundation

final class DoublyLinkedListNode {
    var data: Int
    var next: DoublyLinkedListNode?
    weak var prev: DoublyLinkedListNode?

    public init(nodeData: Int) {
        self.data = nodeData
    }
}

final class DoublyLinkedList {
    var head: DoublyLinkedListNode?
    var tail: DoublyLinkedListNode?

    public init() {}

    public func insertNode(nodeData: Int) {
        self.insertNode(node: DoublyLinkedListNode(nodeData: nodeData))
    }

    private func insertNode(node: DoublyLinkedListNode) {
        if let tail = tail {
            tail.next = node
            node.prev = tail
        } else {
            head = node
        }

        tail = node
    }
}

func printDoublyLinkedList(head: DoublyLinkedListNode?, sep: String, fileHandle: FileHandle) {
    var node = head

    while node != nil {
        fileHandle.write(String(node!.data).data(using: .utf8)!)

        node = node!.next

        if node != nil {
            fileHandle.write(sep.data(using: .utf8)!)
        }
    }
}

// Complete the sortedInsert function below.

/*
 * For your reference:
 *
 * DoublyLinkedListNode {
 *     data: Int
 *     next: DoublyLinkedListNode?
 *     prev: DoublyLinkedListNode?
 * }
 *
 */
func sortedInsert(llist head: DoublyLinkedListNode?, data: Int) -> DoublyLinkedListNode? {
    let node = DoublyLinkedListNode(nodeData: data)
    var prev: DoublyLinkedListNode? = nil
    if var sentinel = head {
        repeat {
            if sentinel.data < data {
                if let next = sentinel.next {
                    sentinel = next
                } else {
                    insertAfter(sentinel, node)
                    return head
                }
            } else {
                insertBefore(sentinel, node)
                return (sentinel === head!) ? node : head
            }
        } while true
    } else {
        return node
    }
}

func insertAfter(_ node: DoublyLinkedListNode, _ new: DoublyLinkedListNode) {
    if let next = node.next {
        next.prev = new
        new.next = next
    }
    node.next = new
    new.prev = node
}

func insertBefore(_ node: DoublyLinkedListNode, _ new: DoublyLinkedListNode) {
    if let prev = node.prev {
        prev.next = new
        new.prev = prev
    }
    node.prev = new
    new.next = node
}

let stdout = ProcessInfo.processInfo.environment["OUTPUT_PATH"]!
FileManager.default.createFile(atPath: stdout, contents: nil, attributes: nil)
let fileHandle = FileHandle(forWritingAtPath: stdout)!

guard let t = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
else { fatalError("Bad input") }

for tItr in 1...t {
    guard let llistCount = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    else { fatalError("Bad input") }

    let llist = DoublyLinkedList()

    for _ in 1...llistCount {
        guard let llistItem = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
        else { fatalError("Bad input") }
        llist.insertNode(nodeData: llistItem)
    }

    guard let data = Int((readLine()?.trimmingCharacters(in: .whitespacesAndNewlines))!)
    else { fatalError("Bad input") }

    let llist1 = sortedInsert(llist: llist.head!, data: data)

    printDoublyLinkedList(head: llist1, sep: " ", fileHandle: fileHandle)
    fileHandle.write("\n".data(using: .utf8)!)
}
