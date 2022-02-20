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
extension Date {
    /// Returns the fraction of time elapsed between two dates, as a Double in the range `0...1`
    public func progress(between start: Date, and end: Date) -> Double {
        guard start < end else { return 0 }
        return min(1, max(0, Date().timeIntervalSince(start) / end.timeIntervalSince(start)))
    }
    
    /// Returns the fraction of time elapsed between two dates, as a Double in the range `0...1`
    public func progress(in interval: ClosedRange<Date>) -> Double {
        progress(between: interval.lowerBound, and: interval.upperBound)
    }
    
    /// Returns boolean if this date is the same day of date in parameter. Without looking hour
    public func isSameDayThan(_ date: Date) -> Bool {
        return midnight == date.midnight
    }
    
    /// Returns the day, month and year components of the Date
    public var dmy: DateComponents {
        Calendar.current.dateComponents([.day, .month, .year], from: self)
    }
    
    /// Returns a Bool indicating whether the Date is in the past
    public var isPast: Bool { timeIntervalSinceNow < 0 }
    
    /// Returns a Bool indicating whether the Date is in the future
    public var isFuture: Bool { timeIntervalSinceNow > 0 }
    
    /// Returns a Bool indicating whether the Date is today, according to the current Calendar
    public var isToday: Bool { midnight == Date().midnight }
    
    /// Returns a Bool indicating whether the Date is tomorrow, according to the current Calendar
    public var isTomorrow: Bool { midnight == Date.tomorrow.midnight }
    
    /// Returns a Date with hour, minute and second components set to 0, according to the current Calendar
    public var midnight: Date {
        Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    
    /// Returns a Date with hour and minute set to a HoursMinute instance, and seconds to zero, according to the current Calendar
    public func at(_ time: HoursMinutes) -> Date {
        Calendar.current.date(bySettingHour: time.hour, minute: time.minute, second: 0, of: self)!
    }
    
    /// Returns the timeInterval since midnight, according to the current Calendar
    public var timeIntervalSinceMidnight: TimeInterval {
        timeIntervalSince(midnight)
    }
    
    /// Returns a Date set to the beginning of the current day, according to the current Calendar
    public static var midnight: Date {
        Date().midnight
    }

    /// Returns the timeInterval of the beginning of the current day, according to the current Calendar
    public static var timeIntervalSinceMidnight: TimeInterval {
        Date().timeIntervalSinceMidnight
    }
    
    /// Returns a Date set to the beginning of tomorrow, according to the current Calendar
    public static var tomorrow: Date {
        Date().midnight >> 1.day
    }
    
    /// Returns a Date set to the beginning of yesterday, according to the current Calendar
    public static var yesterday: Date {
        Date().midnight >> (-1).day
    }
    
    /// Constant: number of seconds in a day
    /// WARNING: this is not always the case. Use with caution.
    public static let secondsInDay: Int = 86400
}
/// Adds a time interval to a date
public func >> (lhs: Date, rhs: TimeInterval) -> Date {
    lhs.addingTimeInterval(rhs)
}

/// Subtracts a time interval from a date
public func << (lhs: Date, rhs: TimeInterval) -> Date {
    lhs.addingTimeInterval(-rhs)
}

/// Adds time components to a date, according to the current Calendar
public func >> (lhs: Date, rhs: DateComponents) -> Date {
    Calendar.current.date(byAdding: rhs, to: lhs)!
}

/// Subtracts time components from a date, according to the current Calendar
public func << (lhs: Date, rhs: DateComponents) -> Date {
    Calendar.current.date(byAdding: rhs.negated, to: lhs)!
}
