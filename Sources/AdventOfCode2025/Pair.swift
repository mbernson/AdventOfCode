//
//  Pair.swift
//  AdventOfCode
//
//  Created by Mathijs Bernson on 09/12/2025.
//

import Foundation

struct Pair<T: Hashable>: Hashable {
    let a: T
    let b: T

    init(_ a: T, _ b: T) {
        self.a = a
        self.b = b
    }

    func hash(into hasher: inout Hasher) {
        let ha = a.hashValue
        let hb = b.hashValue
        hasher.combine(ha &+ hb)
        hasher.combine(ha &* hb)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        (lhs.a == rhs.a && lhs.b == rhs.b)
        || (lhs.a == rhs.b && lhs.b == rhs.a)
    }
}
