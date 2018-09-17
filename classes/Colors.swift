//
//  Colors.swift
//  Distrito Appnimal
//
//  Created by Ivan Espitia on 8/05/18.
//  Copyright © 2018 IDPYBA. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    // Azul select - buttons R:47 - G:138 - B:220
    // Azul options - buttons R:0 - G:152 - B:210
    // Azul fondo - buttons R:0 - G:60 - B:109
    // Gris textFields - buttons R:204 - G:204 - B:204
    // Azul select segment control - buttons R:1 - G:17 - B:41
    // Amarillo button - buttons R:250 - G:255 - B:0
    
    static let blue_select = UIColor(red:0.18, green:0.54, blue:0.86, alpha:1.0)
    static let blue_option_comunity = UIColor(red:0.18, green:0.53, blue:0.76, alpha:1.0)
    static let blue_background = UIColor(red:0.06, green:0.18, blue:0.34, alpha:1.0)
    static let blue_facebook = UIColor(red:0.13, green:0.33, blue:0.54, alpha:1.0)
    static let gray_textFields = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
    static let blue_segment_select = UIColor(red:0.02, green:0.06, blue:0.11, alpha:1.0)
    static let yellow_button = UIColor(red:0.99, green:0.98, blue:0.25, alpha:1.0)
    static let greenAdjunt = UIColor(red:0.13, green:0.64, blue:0.04, alpha:1.0)
    
    static let orangeIcons = UIColor(red:1.00, green:0.60, blue:0.00, alpha:1.0)
    
    static let greenHappines = UIColor(red:0.02, green:0.72, blue:0.05, alpha:1.0)
    static let redHappines = UIColor(red:1.00, green:0.00, blue:0.13, alpha:1.0)
    static let orangeHappines = UIColor(red:0.84, green:0.62, blue:0.06, alpha:1.0)
    
    static func getColorHappines(value: Float) -> UIColor {
        if value > 0 && value < 30 {
            return redHappines
        } else if value > 30 && value < 70 {
            return orangeHappines
        } else {
            return greenHappines
        }
    }
    
}
