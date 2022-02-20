//
//  String+Extension.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit
import CommonCrypto

extension String {
    
    /// Used to localize string
    public var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    public func starts(withAnyOf strings: [String], matchLongerPrefix: Bool = false) -> Bool {
        for string in strings {
            if starts(prefixString: string, matchLongerPrefix: matchLongerPrefix) {
                return true
            }
        }
        return false
    }
    
    public func starts(prefixString: String, matchLongerPrefix: Bool = false) -> Bool {
        guard count > 0 else { return false }
        return starts(with: matchLongerPrefix ? String(prefixString.prefix(count)) : prefixString)
    }
    /// Tests if the string matches a regular expression
    public func matches(_ regex: String) -> Bool {
        range(of: regex, options: [.regularExpression]) != nil
    }
    
    /// Returns a version of the string with diacritics removed (eg: "Älphàbêt" becomes "Alphabet").
    public var withoutDiacritics: String {
        folding(options: [.diacriticInsensitive], locale: .current)
    }
    
    /// Returns the initials of the string, by keeping the first character of each word.
    public var initials: String {
        components(separatedBy: .whitespacesAndNewlines).compactMap { String($0.first ?? Character("")) }.joined()
    }
    
    /// Returns a sort-friendly variant of the string (all lowercase, without diacritics).
    public var forSort: String {
        localizedLowercase.withoutDiacritics
    }
    
    /// Returns a sort-friendly variant of the string (all uppercase, without diacritics, keeping only alphanumerics)
    public var cleanedUp: String {
        String(self
                .folding(options: .diacriticInsensitive, locale: nil)
                .uppercased()
                .unicodeScalars.filter({ CharacterSet.alphanumerics.contains($0) })
        )
    }
    
    public func toEan128Barcode() -> UIImage? {
        let data = self.data(using: .utf8)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        if let outputImage = filter?.outputImage /* 100 x 100 */ {
            let scaleTransform = CGAffineTransform(scaleX: 5, y: 5)
            return UIImage(ciImage: outputImage.transformed(by: scaleTransform))
        } else {
            return nil
        }
    }
    
    public var isAlphanumeric: Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && !isEmpty
    }
    public var hexColorToInteger: Int {
        let cleanString = self.replacingOccurrences(of: "0x", with: "").replacingOccurrences(of: "#", with: "")
        return Int(cleanString, radix: 16) ?? 0
    }
    
    public var canonized: String {
        return lowercased().folding(options: .diacriticInsensitive, locale: Locale.current)
    }

    /// Append new Data from an UTF8 content given by an URL + add a line break
    public func appendNewLine(from: URL) throws {
        try appending("\n").append(from: from)
    }

    /// Append new Data from an UTF8 content given by an URL
    public func append(from: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(from: from)
    }
    
    public var utfData: Data {
        return Data(utf8)
    }
    
    public var attributedHtmlString: NSAttributedString? {
        do {
            return try NSAttributedString(data: utfData, options: [
              .documentType: NSAttributedString.DocumentType.html,
              .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
    public func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()

        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }

        return results.map { String($0) }
    }
    public func attributedString() -> NSAttributedString {
        NSAttributedString(string: self)
    }
}

extension Optional where Wrapped == String {
    public var forSort: String {
        self?.forSort ?? ""
    }
}

extension Collection where Element == String? {
    public func compactJoined(separator: String = "\n") -> String? {
        let mapped = compactMap { $0 }
        return mapped.isEmpty ? nil : mapped.joined(separator: separator)
    }
}
