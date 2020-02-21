//
//  main.swift
//  Roads and Libraries
//
//  Created by Vitor Silva on 20/02/20.
//  Copyright © 2020 Vitor Silva. All rights reserved.
//
//  HackerRank: https://www.hackerrank.com/challenges/torque-and-development/problem

import Foundation

class UF {
    var parent = [Int: Int]()
    var groups: Int

    init(size: Int) {
        self.groups = size
    }

    func parent(of element: Int) -> Int {
        if let parent = parent[element] {
            let grandpa = self.parent(of: parent)
            self.parent[element] = grandpa
            return grandpa
        } else {
            return element
        }
    }

    func unite(_ a: Int, _ b: Int) {
        let parentA = parent(of: a)
        let parentB = parent(of: b)
        
        if parentA != parentB {
            parent[parentB] = parentA
            groups -= 1
        }
    }
}

// Complete the roadsAndLibraries function below.
func roadsAndLibraries(n: Int, c_lib: Int, c_road: Int, cities: [(a: Int, b: Int)]) -> Int {
    if c_lib <= c_road { return c_lib * n }
    else {
        let uf = UF(size: n)
        cities.forEach{ uf.unite($0.a, $0.b); }
        return c_lib * uf.groups + (n - uf.groups) * c_road
    }
}

print("With compression")

let check = [0, 5649516, 5295483, 9261576, 3960530, 7629795, 40216260, 6701050, 40280315, 4614540, 12407190]


let q = Int(readLine()!)!

for qItr in 1...q {
    let nmC_libC_roadTemp = readLine()!
    let nmC_libC_road = nmC_libC_roadTemp.split(separator: " ").map{ String($0) }

    let n = Int(nmC_libC_road[0])!
    let m = Int(nmC_libC_road[1])!
    let c_lib = Int(nmC_libC_road[2])!
    let c_road = Int(nmC_libC_road[3])!

    let cities: [(a: Int, b: Int)] = [(a: Int, b: Int)].init(unsafeUninitializedCapacity: m){ tgt, _ in
        let tmp = readLine()!.split(separator: " ").map{ Int($0)! }
        tgt.assign(repeating: (a: tmp[0], b: tmp[1]))
    }
        
    //let cities: [[Int]] = AnyIterator{ readLine()! }.prefix(m).map {
    //    return $0.split(separator: " ").map{ Int($0)! }
    //}

    let result = roadsAndLibraries(n: n, c_lib: c_lib, c_road: c_road, cities: cities)

    print("\(result) \(result == check[qItr])")
}

/**
 * For some timelimit reason my swift version does not pass the test 2
 * The same logic in lua works:
 * ```
 *  function parent(element, parents)
 *     local father = parents[element]
 *     if father ~= nil then
 *         local grandpa = parent(father, parents)
 *         parents[element] = grandpa
 *         return grandpa
 *     else
 *         return element
 *     end
 * end
 *
 * -- Complete the roadsAndLibraries function below.
 * function roadsAndLibraries(n, c_lib, c_road, cities)
 *     if c_lib <= c_road then
 *         return c_lib * n
 *     else
 *         local parents = {}
 *         local groups = n
 *         for _, v in ipairs(cities) do
 *             local a = v[1]
 *             local b = v[2]
 *              local parentA = parent(a, parents)
 *             local parentB = parent(b, parents)
 *
 *             if parentA ~= parentB then
 *                 parents[parentB] = parentA
 *                 groups = groups - 1
 *             end
 *         end
 *         return c_lib * groups + (n - groups) * c_road
 *     end
 * end
 * ```
 *
 *
 */
