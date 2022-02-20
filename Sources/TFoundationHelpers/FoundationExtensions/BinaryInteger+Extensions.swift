//
//  BinaryInteger+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation
import UIKit

extension BinaryInteger {
    public var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}
