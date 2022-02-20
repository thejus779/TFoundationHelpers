//
//  CommonUtils.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import UIKit

public let baseMargin: CGFloat = 16
public let baseMargin0_25: CGFloat = baseMargin/4
public let baseMargin0_75: CGFloat = (baseMargin/4) * 3
public let baseMargin0_5: CGFloat = baseMargin/2
public let defaultMarginx1_5 = CGFloat(30)
public let defaultMargin = CGFloat(20)
public let defaultMarginx0_75 = CGFloat(15)
public let defaultMarginx0_5 = CGFloat(10)
public let defaultMarginx0_25 = CGFloat(5)

public let baseAnimationInterval: TimeInterval = 0.2 // common duration for UI animations

public extension UITableViewCell {
    static let defaultHeight: CGFloat = 43
}

public struct AnchorPoint {
    public static let northWest = CGPoint(x: 0, y: 0)
    public static let north = CGPoint(x: 0.5, y: 0)
    public static let northEast = CGPoint(x: 1, y: 0)
    public static let west = CGPoint(x: 0, y: 0.5)
    public static let center = CGPoint(x: 0.5, y: 0.5)
    public static let east = CGPoint(x: 1, y: 0.5)
    public static let southWest = CGPoint(x: 0, y: 1)
    public static let south = CGPoint(x: 0.5, y: 1)
    public static let southEast = CGPoint(x: 1, y: 1)
}

public struct UnitAngle {
    public static let north = 3 * CGFloat.pi / 2
    public static let west = CGFloat(0)
    public static let westLow = CGFloat(0)
    public static let westHi = 2 * CGFloat.pi
    public static let south = CGFloat.pi / 2
    public static let east = CGFloat.pi
}

public enum UIRectSide {
    case top
    case left
    case bottom
    case right
}

public extension UIScreen {
    var hairline: CGFloat { 1.0 / scale }
}

public extension CGFloat {
    static var hairline: CGFloat { 1.0 / UIScreen.main.scale }
}

public extension CGSize {
    static let microscopic = CGSize(width: 0.001, height: 0.001)
}

public extension NSLayoutConstraint {
    typealias Axes = Set<Axis>
    typealias Attributes = Set<Attribute>
}

public extension NSLayoutConstraint.Axes {
    static let all: NSLayoutConstraint.Axes = [.horizontal, .vertical]
    static let horizontal: NSLayoutConstraint.Axes = [.horizontal]
    static let vertical: NSLayoutConstraint.Axes = [.vertical]
    
    var isHorizontal: Bool { contains(.horizontal) }
    var isVertical: Bool { contains(.vertical) }
}

public extension NSLayoutConstraint.Attributes {
    static let all: NSLayoutConstraint.Attributes = [.top, .bottom, .leading, .trailing]
    static let horizontal: NSLayoutConstraint.Attributes = [.leading, .trailing]
    static let vertical: NSLayoutConstraint.Attributes = [.top, .bottom]
    static let size: NSLayoutConstraint.Attributes = [.width, .height]
    static let top: NSLayoutConstraint.Attributes = [.top]
    static let bottom: NSLayoutConstraint.Attributes = [.bottom]
    static let leading: NSLayoutConstraint.Attributes = [.leading]
    static let trailing: NSLayoutConstraint.Attributes = [.trailing]
    static let width: NSLayoutConstraint.Attributes = [.width]
    static let height: NSLayoutConstraint.Attributes = [.height]
    static let center: NSLayoutConstraint.Attributes = [.centerX, .centerY]
    static let centerX: NSLayoutConstraint.Attributes = [.centerX]
    static let centerY: NSLayoutConstraint.Attributes = [.centerY]
    
    static let allButTop: NSLayoutConstraint.Attributes = [.bottom, .leading, .trailing]
    static let allButBottom: NSLayoutConstraint.Attributes = [.top, .leading, .trailing]
    static let allButLeading: NSLayoutConstraint.Attributes = [.top, .bottom, .trailing]
    static let allButTrailing: NSLayoutConstraint.Attributes = [.top, .bottom, .leading]
}


extension UIView {
    public struct MarginSet {
        public let t, b, l, r: Bool
        
        public static let horizontal = MarginSet(t: false, b: false, l: true, r: true)
        public static let vertical = MarginSet(t: true, b: true, l: false, r: false)
        public static let all = MarginSet(t: true, b: true, l: true, r: true)
        public static let none = MarginSet(t: false, b: false, l: false, r: false)
    }
}

