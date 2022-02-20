//
//  UUID+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension UUID {
    static func from(userDefaults: UserDefaults, key: String) -> UUID? {
        guard let string = userDefaults.object(forKey: key) as? String else { return nil }
        return UUID(uuidString: string)
    }
}
public extension UUID {
    /// The zero UUID
    static let zero = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
}

/// Make all UUIDs identifiable
extension UUID: Identifiable {
    public var id: String { uuidString }
}
