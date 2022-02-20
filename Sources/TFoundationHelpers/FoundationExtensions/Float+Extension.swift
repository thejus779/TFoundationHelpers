//
//  Float+Extension.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension Float {
    func stringByStrippingIntegerDecimal(minDigitLimit: Int = 2) -> String {
        let isInteger = floor(self) == self
        
        return isInteger ?
            "\(Int(self))"
            : "\(NumberFormatter.commaFormatter(minDigitLimit: minDigitLimit, maxDigitLimit: nil).string(for: self) ?? "")"
    }
    static func from(_ decimal: Decimal?) -> Float? {
        return (decimal as NSDecimalNumber?)?.floatValue
    }
}
extension Float {
    var asCurrencyStyle: String {
        let formatter = (self.truncatingRemainder(dividingBy: 1) == 0) ?
            NumberFormatter.integerPrice : NumberFormatter.price
        return formatter.string(from: NSNumber(value: self))!
    }
    var asPriceWithoutCurrency: String {
        asCurrencyStyle.replacingOccurrences(of: "€", with: "").replacingOccurrences(of: " ", with: "")
    }
    var asStringifiedPrice: String {
        let formatter = (self.truncatingRemainder(dividingBy: 1) == 0) ?
            NumberFormatter.intergerPriceFormatter : NumberFormatter.priceFormatter
        return formatter.string(from: NSNumber(value: self))!
    }
    
}
