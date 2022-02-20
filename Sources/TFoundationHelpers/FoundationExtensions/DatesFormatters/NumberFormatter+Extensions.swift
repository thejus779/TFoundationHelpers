//
//  NumberFormatter+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

extension NumberFormatter {
    static var priceFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "fr_FR")
        nf.numberStyle = .none
        nf.currencyCode = "EUR"
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        return nf
    }()
    
    static var intergerPriceFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "fr_FR")
        nf.numberStyle = .none
        nf.currencyCode = "EUR"
        nf.maximumFractionDigits = 0
        nf.minimumFractionDigits = 0
        return nf
    }()
    
    @nonobjc static var decimal: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "fr_FR")
        nf.numberStyle = .decimal
        return nf
    }()

    @nonobjc static var price: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "fr_FR")
        nf.numberStyle = .currency
        nf.currencyCode = "EUR"
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 2
        return nf
    }()

    @nonobjc static var integerPrice: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "fr_FR")
        nf.numberStyle = .currency
        nf.currencyCode = "EUR"
        nf.maximumFractionDigits = 0
        nf.minimumFractionDigits = 0
        return nf
    }()

    @nonobjc static var gigabyteSize: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "fr_FR")
        nf.maximumFractionDigits = 2
        nf.minimumFractionDigits = 0
        nf.positiveSuffix = "Go"
        nf.negativeSuffix = "Go"
        return nf
    }()
    
    public static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
    
    static func commaFormatter(minDigitLimit: Int? = 2, maxDigitLimit: Int? = 2) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let minDigitLimit = minDigitLimit {
            formatter.minimumFractionDigits = minDigitLimit
        }
        if let maxDigitLimit = maxDigitLimit {
            formatter.maximumFractionDigits = maxDigitLimit
        }
        return formatter
    }
}
