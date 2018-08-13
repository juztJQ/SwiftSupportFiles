//
//  UIColorExtension.swift
//  Koyomi
//
//  Created by Shohei Yokoyama on 2016/10/21.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red   = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue  = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    struct Color {
        static let darkBlack: UIColor = .init(hex: 0x1F1F21)
        static let lightGray: UIColor = .init(hex: 0xc3c3ca)
        static let darkGray: UIColor  = .init(hex: 0x878787)
        static let red: UIColor       = .init(hex: 0xff3b30)
        static let orange: UIColor    = .init(hex: 0xff9500)
        static let green: UIColor     = .init(hex: 0x4cd964)
        static let blue: UIColor      = .init(hex: 0x007aff)
        static let purple: UIColor    = .init(hex: 0x5856d6)
        static let yellow: UIColor    = .init(hex: 0xffcc00)
        static let tealBlue: UIColor  = .init(hex: 0x5ac8fa)
        static let pink: UIColor      = .init(hex: 0xff2d55)
    }
    
    @nonobjc class var piYellow: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 207.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piLightOrange: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 189.0 / 255.0, blue: 57.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piPeach: UIColor {
        return UIColor(red: 238.0 / 255.0, green: 103.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var piPaleGrey: UIColor {
        return UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piLipstick: UIColor {
        return UIColor(red: 227.0 / 255.0, green: 29.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piMango: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 141.0 / 255.0, blue: 43.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piCharcoalGrey: UIColor {
        return UIColor(red: 58.0 / 255.0, green: 65.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piCoolGrey: UIColor {
        return UIColor(red: 173.0 / 255.0, green: 179.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piDarkGrey: UIColor {
        return UIColor(red: 27.0 / 255.0, green: 28.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piDodgerBlue: UIColor {
        return UIColor(red: 60.0 / 255.0, green: 165.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piDarkSkyBlue: UIColor {
        return UIColor(red: 40.0 / 255.0, green: 188.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piBarney: UIColor {
        return UIColor(red: 144.0 / 255.0, green: 22.0 / 255.0, blue: 175.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piSicklyYellow: UIColor {
        return UIColor(red: 188.0 / 255.0, green: 214.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piAqua: UIColor {
        return UIColor(red: 40.0 / 255.0, green: 196.0 / 255.0, blue: 233.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piPaleOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 160.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piBerry: UIColor {
        return UIColor(red: 175.0 / 255.0, green: 22.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var piBarneyPurple: UIColor {
        return UIColor(red: 133.0 / 255.0, green: 6.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var piDark: UIColor {
        return UIColor(red: 48.0 / 255.0, green: 39.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piDarkTwo: UIColor {
        return UIColor(red: 23.0 / 255.0, green: 16.0 / 255.0, blue: 28.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piSicklyYellowTwo: UIColor {
        return UIColor(red: 196.0 / 255.0, green: 227.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piWhite: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piDarkThree: UIColor {
        return UIColor(red: 26.0 / 255.0, green: 20.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piPaleGreyTwo: UIColor {
        return UIColor(red: 218.0 / 255.0, green: 210.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piPaleGreyThree: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 239.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piDarkFour: UIColor {
        return UIColor(red: 37.0 / 255.0, green: 30.0 / 255.0, blue: 44.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piDarkFive: UIColor {
        return UIColor(red: 43.0 / 255.0, green: 35.0 / 255.0, blue: 51.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var piDarkishBlue: UIColor {
      return UIColor(red: 0.0, green: 73.0 / 255.0, blue: 131.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var piRobinSEgg: UIColor {
        return UIColor(red: 121.0 / 255.0, green: 229.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
}

// Sample text styles

    extension UIFont {
        class func piTextStyleFont() -> UIFont? {
            return UIFont(name: "TrumpGothicEast", size: 60.0)
        }
}
