//
//  NSAttributedString+Extensions.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func attributedString(
        text: String,
        font: UIFont,
        color: UIColor,
        lineHeight: CGFloat? = nil,
        alignment: NSTextAlignment = NSTextAlignment.center,
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        kern: CGFloat = 0,
        strikethroughStyle: NSUnderlineStyle = [],
        underlineStyle: NSUnderlineStyle = [],
        baselineOffset: CGFloat = 0,
        associatedUrl: URL? = nil
    ) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight ?? font.pointSize
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        
        var attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle,
            .kern: kern
        ]
        
        if baselineOffset != 0 {
            attributes[.baselineOffset] = baselineOffset
        }
        attributes[.strikethroughStyle] = strikethroughStyle.rawValue
        if !underlineStyle.isEmpty {
            attributes[.underlineStyle] = underlineStyle.rawValue
        }
        if let associatedUrl = associatedUrl {
            attributes[.link] = associatedUrl
        }
        
        return NSMutableAttributedString(
            string: text,
            attributes: attributes
        )
    }
    
    static func twoPartsString(
        string1: String, string2: String,
        string1Color: UIColor = .black,
        string2Color: UIColor = .red,
        string1Font: UIFont,
        string2Font: UIFont,
        lineHeight: CGFloat? = nil,
        alignment: NSTextAlignment = NSTextAlignment.center,
        lineBreakMode: NSLineBreakMode = .byWordWrapping,
        string1StrikethroughStyle: NSUnderlineStyle = [],
        string2StrikethroughStyle: NSUnderlineStyle = [],
        string1UnderlineStyle: NSUnderlineStyle = [],
        string2UnderlineStyle: NSUnderlineStyle = [],
        string1BaselineOffset: CGFloat = 0,
        string2BaselineOffset: CGFloat = 0
    ) -> NSMutableAttributedString {
        return concatenating(
            NSAttributedString.attributedString(
                text: string1,
                font: string1Font,
                color: string1Color,
                lineHeight: lineHeight ?? string1Font.pointSize,
                alignment: alignment,
                lineBreakMode: lineBreakMode,
                strikethroughStyle: string1StrikethroughStyle,
                underlineStyle: string1UnderlineStyle,
                baselineOffset: string1BaselineOffset
            ),
            NSAttributedString.attributedString(
                text: string2,
                font: string2Font,
                color: string2Color,
                lineHeight: lineHeight ?? string2Font.pointSize,
                alignment: alignment,
                lineBreakMode: lineBreakMode,
                strikethroughStyle: string2StrikethroughStyle,
                underlineStyle: string2UnderlineStyle,
                baselineOffset: string2BaselineOffset
            )
        )
    }
    static func concatenating(_ args: NSAttributedString...) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        args.forEach { attributedString.append($0) }
        return attributedString
    }
}
