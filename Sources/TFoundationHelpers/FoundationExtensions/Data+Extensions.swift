//
//  Data+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension Data {
    public func mapJSON(failsOnEmptyData: Bool = true) throws -> Any {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            if count < 1 && !failsOnEmptyData {
                return NSNull()
            }
            throw NSError(domain: "Data.mapJSON", code: 1, userInfo: nil)
        }
    }
    
    public mutating func appendString(_ string: String) {
        guard let data = string.data(using: .utf8, allowLossyConversion: false) else { return }
        append(data)
    }
}
extension Data {
    /// Append new Data from a content given by an URL
    public func append(from: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: from.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: from, options: .atomic)
        }
    }
}
