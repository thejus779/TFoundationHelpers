//
//  DateComponents+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension DateComponents {
    static let chronologicalFormatter: (DateComponents, DateComponents) -> Bool = { dc1, dc2 in
        guard   let dc1year = dc1.year, let dc2year = dc2.year,
            let dc1month = dc1.month, let dc2month = dc2.month else {
                return false
        }
        if dc2year < dc1year {
            return true
        } else if dc1year < dc2year {
            return false
        } else {
            return dc2month < dc1month
        }
    }
}
