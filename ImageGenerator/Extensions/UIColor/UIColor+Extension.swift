//
//  UIColor+Extension.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

extension UIColor {
    convenience init(red intRed: UInt, green intGreen: UInt, blue intBlue: UInt, alpha: CGFloat = 1) {
        self.init(red: CGFloat(intRed) / 255.0, green: CGFloat(intGreen) / 255.0, blue: CGFloat(intBlue) / 255.0, alpha: alpha)
    }
    
    convenience init(_ rgb: UInt, alpha: CGFloat = 1) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha)
    }
    
    convenience init(_ hexValue: String, alpha: CGFloat = 1) {
        var colorString = hexValue.trimmingCharacters(in:CharacterSet.alphanumerics.inverted)
        
        if colorString.count > 6 {
            colorString = String(colorString[..<6])
        }
        
        if colorString.count < 2 {
            colorString.append("0")
        }
        let red = String(colorString[..<2])
        guard colorString.count > 2 else {
            self.init(red: red, alpha: alpha)
            return
        }
        
        if colorString.count < 4 {
            colorString.append("0")
        }
        let green = String(colorString[2..<4])
        guard colorString.count > 4 else {
            self.init(red: red, green: green, alpha: alpha)
            return
        }
        
        if colorString.count < 6 {
            colorString.append("0")
        }
        let blue = String(colorString[4..<6])
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(red hexRed: String = "", green hexGreen: String = "", blue hexBlue: String = "", alpha: CGFloat = 1) {
        var redValue = UInt64(), greenValue = UInt64(), blueValue = UInt64()
        Scanner(string: hexRed).scanHexInt64(&redValue)
        Scanner(string: hexGreen).scanHexInt64(&greenValue)
        Scanner(string: hexBlue).scanHexInt64(&blueValue)
        self.init(red: UInt(redValue & 0xFF), green: UInt(greenValue & 0xFF), blue: UInt(blueValue & 0xFF), alpha: alpha)
    }
    
    convenience init(hue intHue: UInt, saturation intSaturation: UInt, brightness intBrightness: UInt, alpha: CGFloat = 1) {
        self.init(hue: CGFloat(intHue % 360) / 360.0, saturation: CGFloat(intSaturation) / 100.0, brightness: CGFloat(intBrightness) / 100.0, alpha: alpha)
    }
    
    convenience init(white intWhite: Int, alpha: CGFloat = 1) {
        self.init(white: CGFloat(intWhite) / 255.0, alpha: alpha)
    }
}


// MARK: - App Colors

extension UIColor {
   
    static let buttonStandard = UIColor("25D366")

    static let buttonGray = UIColor("BDBDBD")
    static let buttonBorder1 = UIColor("2F6CDD")
    static let buttonBorder2 = UIColor("2F6CDD").withAlphaComponent(0.3)
    static let buttonBackground1 = UIColor("2F6CDD").withAlphaComponent(0.3)
    static let buttonBackground2 = UIColor("2F6CDD").withAlphaComponent(0.1)
}
