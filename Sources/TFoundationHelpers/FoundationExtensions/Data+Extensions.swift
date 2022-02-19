//
//  Data+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension Data {
    func mapJSON(failsOnEmptyData: Bool = true) throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            if count < 1 && !failsOnEmptyData {
                return NSNull()
            }
            throw NSError(domain: "Data.mapJSON", code: 1, userInfo: nil)
        }
    }
    
    mutating func appendString(_ string: String) {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else { return }
        append(data)
    }
}
