//
//  Extension+UIColor.swift
//  EventHub
//
//  Created by Олег Дербин on 18.11.2024.
//

import UIKit

extension UIColor {
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
