//
//  TimeInterval+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension TimeInterval {
    var minutes: Int {
        return Int((self / 60).truncatingRemainder(dividingBy: 60))
    }
    var hours: Int {
        return Int(self / (60 * 60))
    }
}
