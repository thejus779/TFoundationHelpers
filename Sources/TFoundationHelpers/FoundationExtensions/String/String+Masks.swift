//
//  String+Masks.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension String {
    
    private subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: range.lowerBound)
        let idx2 = index(startIndex, offsetBy: range.upperBound)
        return String(self[idx1..<idx2])
    }
    public func applyingMonthYearMask() -> String {
        guard count >= 2 else { return self }
        var baseString = removingSlashes()
        baseString.insert("/", at: index(startIndex, offsetBy: 2))
        return baseString
    }
    
    public func applyingCardNumberMask() -> String {
        return spaceChars(per: 4)
    }
    private func spaceChars(per batch: Int) -> String {
        var result = ""
        self.removingSpaces().enumerated().forEach { index, character in
            if index % batch == 0 && index > 0 {
                result += " "
            }
            result.append(character)
        }
        return result
    }
    
    public func removingSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    public func removingSlashes() -> String {
        return self.replacingOccurrences(of: "/", with: "")
    }
    
    public func barCodeStringByApplyingEAN13Mask() -> String {
        if self.count != 13 {
            return self
        }
        let index1 = index(startIndex, offsetBy: 1)
        let index2 = index(index1, offsetBy: 6)
        let index3 = index(index2, offsetBy: 6)
        
        return String(format: "%@ %@ %@", String(prefix(upTo: index1)), String(self[index1..<index2]), String(self[index2..<index3]))
    }
}
