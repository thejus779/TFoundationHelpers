//
//  File.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension Array {
    func shiftRight(amount: Int = 1) -> [Element] {
        var amount = amount
        assert(-count...count ~= amount, "Shift amount out of bounds")
        if amount < 0 { amount += count }  // this needs to be >= 0
        let slice1: ArraySlice<Element> = self[amount ..< count]
        let slice2: ArraySlice<Element> = self[0 ..< amount]
        return Array(slice1 + slice2)
    }
    
    
    /// Returns (.left/.both, .right/.both)
    /// Split array according to conditions to left, right and discarded arrays
    func splitFilter(isIncludedIn: @escaping (Element) -> SplitFilterResult) -> ([Element], [Element], [Element]) {
        var left = [Element]()
        var right = [Element]()
        var discarded = [Element]()
        for e in self {
            switch isIncludedIn(e) {
            case .left:
                left.append(e)
            case .right:
                right.append(e)
            case .both:
                left.append(e)
                right.append(e)
            case .discard:
                discarded.append(e)
            }
        }
        return (left, right, discarded)
    }
    
    enum SplitFilterResult {
        case left
        case right
        case both
        case discard
    }
}

