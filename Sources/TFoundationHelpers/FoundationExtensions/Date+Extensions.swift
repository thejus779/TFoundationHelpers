//
//  Date+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension Date {
    
    @nonobjc static let dayNamedmFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.dateFormat = "EEEE dd/MM"
        return df
    }()
    
    @nonobjc static let dayNamedmyFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.dateFormat = "EEEE dd/MM/yy"
        return df
    }()

    @nonobjc static let dmFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM"
        return df
    }()
    
    @nonobjc static let dmyFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()

    @nonobjc static let dmyhmsFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return df
    }()

    @nonobjc static let mediumDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        df.locale = Locale(identifier: "fr_FR")
        return df
    }()

    @nonobjc static var fullDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr")
        df.dateFormat = "dd MMMM yyyy"
        return df
    }()
    
    static func hoursMinutesDateTimeFormatter(separator: String = ":") -> DateFormatter {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr")
        df.dateFormat = "HH'\(separator)'mm"
        return df
    }
    
    @nonobjc static let hoursMinutesDateAltTimeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr")
        df.dateFormat = "H'h'mm"
        return df
    }()
    
    @nonobjc static let weekDayIndexFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr")
        df.dateFormat = "e"
        return df
    }()
    
    @nonobjc static let weekDayFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr")
        df.dateFormat = "EEEE"
        return df
    }()
    
    static let defaultDate = "01/01/1980"

    static func fromDMY(_ dmy: String) -> Date? {
        return Date.dmyFormatter.date(from: dmy)
    }

    var iso8601: String {
        return Formatter.dateTimeIso8601.string(from: self)
    }
    
    func daysUntilNow(useStartOfday: Bool = true) -> Int? {
        return componentsUntilNow(components: [.day], useStartOfday: useStartOfday).day
    }
    func hoursUntilNow() -> Int? {
        return componentsUntilNow(components: [.hour], useStartOfday: false).hour
    }
    
    private func componentsUntilNow(components: Set<Calendar.Component>, useStartOfday: Bool) -> DateComponents {
        let calendar = NSCalendar.current
        
        return calendar.dateComponents(
            components,
            from: useStartOfday ? calendar.startOfDay(for: Date()) : Date(),
            to: useStartOfday ? calendar.startOfDay(for: self) : self
        )
    }
    
    func offsetedBy(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date()
    }
    func isSameDay(as date: Date) -> Bool {
        let day = Calendar.current.component(.day, from: self)
        let day2 = Calendar.current.component(.day, from: date)

        let month = Calendar.current.component(.month, from: self)
        let month2 = Calendar.current.component(.month, from: date)

        let year = Calendar.current.component(.year, from: self)
        let year2 = Calendar.current.component(.year, from: date)

        return day == day2 && month == month2 && year == year2
    }
    
    static func getDayOfWeek(_ dayName: String, locale: Locale) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = locale
        guard let date = formatter.date(from: dayName) else { return nil }
        return Date.getDayOfWeek(date)
    }
    
    static func getDayOfWeek(_ date: Date) -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        return myCalendar.component(.weekday, from: date)
    }
    
    var timeIntervalSinceMidnight: TimeInterval {
        return self.timeIntervalSince(Calendar.current.startOfDay(for: self))
    }
    
    static let frenchFullWordDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.dateFormat = "EEEE dd MMMM"
        return df
    }()
    
    static let frenchFullWordDateWithYearFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_FR")
        df.dateFormat = "EEEE dd MMMM yyyy"
        return df
    }()

    // MARK: - Components comparison
    private func transposed(to components: Set<Calendar.Component>) -> Date? {
        let calendar = Calendar.current
        let components = calendar.dateComponents(components, from: self)
        return calendar.date(from: components)
    }
    func isAnteriorOrEqualTo(date: Date, comparisonUsing components: Set<Calendar.Component>) -> Bool {
        guard   let selfTransposed = transposed(to: components),
                let otherTransposed = date.transposed(to: components)
            else { return false }
        return selfTransposed <= otherTransposed
    }
    func isPosteriorOrEqualTo(date: Date, comparisonUsing components: Set<Calendar.Component>) -> Bool {
        guard   let selfTransposed = transposed(to: components),
                let otherTransposed = date.transposed(to: components)
            else { return false }
        return selfTransposed >= otherTransposed
    }
}
