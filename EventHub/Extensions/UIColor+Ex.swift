//
//  UIColor+Ex.swift
//  EventHub
//
//  Created by Даниил Павленко on 18.11.2024.
//

import UIKit

extension UIColor {
    
    static let PrimaryBlue = UIColor(named: "PrimaryBlue")
    static let SecondaryCyan = UIColor(named: "SecondaryCyan")
    
    static let AccentDarkCyan = UIColor(named: "AccentDarkCyan")
    static let AccentGreen = UIColor(named: "AccentGreen")
    static let AccentOrange = UIColor(named: "AccentOrange")
    static let AccentPurple = UIColor(named: "AccentPurple")
    static let AccentRed = UIColor(named: "AccentRed")
    static let AccentYellow = UIColor(named: "AccentYellow")
    
    static let BackgroundBlack = UIColor(named: "BackgroundBlack")
    static let BackgroundBlack2 = UIColor(named: "BackgroundBlack2")
    static let BackgroundGray = UIColor(named: "BackgroundGray")
    
    static let TypographyBlack = UIColor(named: "TypographyBlack")
    static let TypographyBlack2 = UIColor(named: "TypographyBlack2")
    static let TypographyGray = UIColor(named: "TypographyGray")
    static let TypographyGray2 = UIColor(named: "TypographyGray2")
    static let TypographyGray3 = UIColor(named: "TypographyGray3")
    static let TypographyGray4 = UIColor(named: "TypographyGray4")
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }

    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formattedHex = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if formattedHex.hasPrefix("#") {
            formattedHex.removeFirst()
        }
        guard let hexNumber = Int(formattedHex, radix: 16) else { return nil }
        self.init(hex: hexNumber, alpha: alpha)
    }
    
}
