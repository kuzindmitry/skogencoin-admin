//
//  UIColor.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 20/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import UIKit

public enum UIColorInputError : Error {
    case missingHashMarkAsPrefix,
    unableToScanHexValue,
    mismatchedHexStringLength
}

extension UIColor {
    
    static var brandOrangeColor: UIColor {
        return try! UIColor(rgba_throws: "#FF5E3A")
    }
    
}

extension UIColor {
    
    public convenience init(rgba_throws rgba: String) throws {
        guard rgba.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        
        let hexString = String(rgba.dropFirst())
        var hexValue: UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }
        
        let divisor = CGFloat(255)
        let red     = CGFloat((hexValue & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hexValue & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hexValue & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    public func hexString(_ includeAlpha: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if includeAlpha {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
}

extension String {
    
    public func argb2rgba() -> String? {
        guard self.hasPrefix("#") else {
            return nil
        }
        
        let hexString: String.SubSequence = self[index(startIndex, offsetBy: 1)...]
        switch (hexString.count) {
        case 4:
            return "#" + hexString.dropFirst() + hexString.prefix(1)
        case 8:
            return "#" + hexString.dropFirst(2) + hexString.prefix(2)
        default:
            return nil
        }
    }
    
}
