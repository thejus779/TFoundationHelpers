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
