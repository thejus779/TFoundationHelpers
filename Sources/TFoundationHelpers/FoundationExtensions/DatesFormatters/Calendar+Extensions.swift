//
//  Calendar+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension Calendar {
    func endOfDay(for date: Date) -> Date {
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: date)
        return nextDay?.addingTimeInterval(-1) ?? .distantFuture
    }
}
