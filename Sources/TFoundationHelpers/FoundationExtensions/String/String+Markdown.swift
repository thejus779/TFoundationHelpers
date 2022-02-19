//
//  String+Markdown.swift
//  
//
//  Created by Thejus Thejus on 27/12/2021.
//  
//

import Foundation
import UIKit

extension String {
    func miniMarkdown(baseFont regular: UIFont, boldFont bold: UIFont, color: UIColor = .black, lineHeightMultiple: CGFloat? = nil) -> NSAttributedString {
        
        // Using localized strings make them UTF-16.
        // Range formation or removeSubrange fails on UTF-16 when there are accentuated characters.
        // It's strange to explain, but I have isolated the case in a single-view project.
        // Solution: get the utf8 data, then reconstruct a string from it.
        // An alternative is to cast self as NSString, and use only "old" methods, namely:
        // text = text.replacingCharacters(in: startRange, with: "") as NSString
        
        var text = data(using: .utf8).flatMap({ String(data: $0, encoding: .utf8) }) ?? self
        var boldRanges: [NSRange] = []
        var underlineRanges: [NSRange] = []
        
        repeat {
            // Find first token (else we're done and this is our exit case)
            guard let (token, start) = ["**", "_"].compactMap({ token -> (String, Range<Index>)? in
                text.range(of: token).map { (token, $0) }
            }).sorted(by: { lhs, rhs -> Bool in
                lhs.1.lowerBound < rhs.1.lowerBound
            }).first else { break }
            
            // Make a copy in case there's no end token, find end token, remove both tokens
            var newText = text
            newText.removeSubrange(start)
            guard let end = newText.range(of: token) else { continue }
            newText.removeSubrange(end)
            text = newText
            
            let nsRange = NSRange(start.lowerBound ..< end.lowerBound, in: text)
            switch token {
            case "**": boldRanges.append(nsRange)
            case "_": underlineRanges.append(nsRange)
            default: continue
            }
        }
        while true
                
        let string = NSMutableAttributedString(string: text, attributes: [.font: regular, .foregroundColor: color])
        for range in boldRanges {
            string.addAttributes([.font: bold], range: range)
        }
        for range in underlineRanges {
            string.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        }
        if let lineHeightMultiple = lineHeightMultiple {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1.0
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            string.addAttributes([.paragraphStyle: paragraphStyle], range: NSMakeRange(0, string.length))
        }
        return string
    }
}
