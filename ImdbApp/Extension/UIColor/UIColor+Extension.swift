//
//  UIColor+Extension.swift
//  ImdbApp
//
//  Created by Tom on 05/02/2022.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let rgb = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: rgb.R, green: rgb.G, blue: rgb.B, alpha: 1)
    }
    
    static let appYellow = UIColor(hex: 0xFAF7F0)
    static let gradientYellow = UIColor(hex: 0xFFFDF9)
}
