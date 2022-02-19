//
//  UIBarButtonItem+Extension.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    struct WrappingUIButton {
        let button: UIButton
        let barButtonItem: UIBarButtonItem
    }
    
    func configureDefaultStyle(normalTextColor: UIColor = .black, disabledColor: UIColor = .gray, font: UIFont) {
        let defaultBBTitleAttributes = [ NSAttributedString.Key.font: font,
                                                NSAttributedString.Key.foregroundColor: normalTextColor ]
        
        let disabledBBTitleAttributes = [ NSAttributedString.Key.font: font,
                                                 NSAttributedString.Key.foregroundColor: disabledColor ]

        setTitleTextAttributes(defaultBBTitleAttributes, for: .normal)
        setTitleTextAttributes(defaultBBTitleAttributes, for: .highlighted)
        setTitleTextAttributes(disabledBBTitleAttributes, for: .disabled)
    }
    
    static func button(with image: UIImage?, size: CGSize, target: Any, selector: Selector, title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil) -> WrappingUIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(target, action: selector, for: .touchUpInside)

        if let image = image {
            button.setImage(image, for: .normal)
        }
        
        if let title = title {
            button.setTitle(title, for: .normal)
        }
        
        if let titleColor = titleColor {
            button.setTitleColor(titleColor, for: .normal)
        }
        
        if let font = font {
            button.titleLabel?.font = font
        }
        
        return WrappingUIButton(button: button, barButtonItem: UIBarButtonItem(customView: button))
    }
}
