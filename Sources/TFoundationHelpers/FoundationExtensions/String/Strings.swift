//
//  File.swift
//  
//
//  Created by Thejus Thejus on 20/02/2022.
//

import Foundation

// Easy NSLocalizedString operators
// "hello"† == NSLocalizedString("hello", comment: "?⃤ hello ?⃤")
// "hello"‡ == NSLocalizedString("hello", comment: "?⃤ hello ?⃤").localizedUppercase

// Cross † is done as alt+T on a US (QWERTY) or FR (AZERTY) keyboard
// Looks like a T, reads like Translated
// Double-cross ‡ is done as shift+alt+7 on a US (QWERTY), or alt+Q on a FR (AZERTY) keyboard.
postfix operator †
public postfix func † (left: String) -> String {
    NSLocalizedString(left, comment: "?⃤ " + left + " ?⃤")
}

postfix operator ‡
public postfix func ‡ (left: String) -> String {
    NSLocalizedString(left, comment: "?⃤ " + left + " ?⃤").localizedUppercase
}
