//
//  String+Validation.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//
import Foundation

/**
 * Used to check specific type of string
 * isSecretCodeValid logic could change
 */
extension String {
    public var isSecretCodeValid: Bool {
        if self.count < 8 { return false }
        if self.count > 16 { return false }

        if let regex = try? NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: []) {
            if regex.firstMatch(in: self,
                                options: .init(rawValue: 0),
                                range: NSRange(location: 0, length: self.count)) != nil {
                // contains special symbol
                return false
            }
            if self.rangeOfCharacter(from: NSCharacterSet.letters) == nil {
                // no letters
                return false
            }
            if self.rangeOfCharacter(from: NSCharacterSet.decimalDigits) == nil {
                // no digits
                return false
            }
        }
        return true
    }
    
    public func validForRegex(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    public func validForLength(_ length: Int) -> Bool {
        return count >= length
    }
    
    public var isEmailValid: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public var constainsNumber: Bool {
        return validForRegex(".*[0-9]+.*")
    }
    
    public var validForUppercaseAndLowercase: Bool {
        return validForRegex(".*[A-Z]+.*") && validForRegex(".*[a-z]+.*")
    }
    
    public var validForSpecialCharacters: Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil
    }
    public func containsAnyOf(strings: [String]) -> Bool {
        return strings.contains(where: contains)
    }
    public var isValidName: Bool {
        validForRegex("^[a-zA-Z `-À-ÖØ-öø-ÿ]+")
    }
    
}
