//
//  String+StoreVersioning.swift
//  
//
//  Created by Thejus Thejus on 12/11/2021.
//
//

import Foundation
extension String {
    private func compare(toVersion targetVersion: String) -> ComparisonResult {
        let versionDelimiter = "."
        var result: ComparisonResult = .orderedSame
        var versionComponents = components(separatedBy: versionDelimiter).compactMap(Double.init).map { String($0) }
        var targetComponents = targetVersion.components(separatedBy: versionDelimiter).compactMap(Double.init).map { String($0) }

        while versionComponents.count < targetComponents.count { versionComponents.append("0") }
        while targetComponents.count < versionComponents.count { targetComponents.append("0") }

        for (version, target) in zip(versionComponents, targetComponents) {
            result = version.compare(target, options: .numeric)
            if result != .orderedSame {
                break
            }
        }
        return result
    }
    
    public func isVersionGreaterThanEqualTo(_ b: String) -> Bool {
        // Expecting
        let arrA = self.components(separatedBy: "-")
        let arrB = b.components(separatedBy: "-")
        guard arrA.count <= 2, arrB.count <= 2 else { return false }
        let versionA = arrA.first ?? "0"
        let versionAMinor = arrA.count < 2 ? "" : arrA.last ?? ""
        let versionB = arrB.first ?? "0"
        let versionBMinor = arrB.count < 2 ? "" : arrB.last ?? ""
        
        if versionA.isVersion(greaterThan: versionB) {
            return true
        } else if versionA.isVersion(equalTo: versionB) {
            return alphaNumericVersionGreaterThan(a: versionAMinor, b: versionBMinor)
        } else {
            return false
        }
    }
    
    public func alphaNumericVersionGreaterThan(a: String, b: String) -> Bool {
        let aStr = a.components(separatedBy: CharacterSet.decimalDigits).first ?? ""
        let aNumeric = a.components(separatedBy: aStr).last ?? "0"
        
        let bStr = b.components(separatedBy: CharacterSet.decimalDigits).first ?? ""
        let bNumeric = b.components(separatedBy: bStr).last ?? "0"
        
        if aStr > bStr {
            return true
        } else if aStr == bStr {
            return aNumeric.isVersion(greaterThanOrEqualTo: bNumeric)
        } else {
            return false
        }
    }

    private func isVersion(equalTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedSame }

    private func isVersion(greaterThan targetVersion: String) -> Bool { return compare(toVersion: targetVersion) == .orderedDescending }

    private func isVersion(greaterThanOrEqualTo targetVersion: String) -> Bool { return compare(toVersion: targetVersion) != .orderedAscending }
}
