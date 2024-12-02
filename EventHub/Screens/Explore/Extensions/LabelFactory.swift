//
//  LabelFactory.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 29.11.2024.
//

import UIKit

final class LabelFactory {
    
    static func goingLabel(fontSize size: Int, color: UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = color
        label.font = .systemFont(ofSize: CGFloat(size))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func locationLabel(fontSize size: Int, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat(size))
        label.numberOfLines = 0
        label.textColor = color
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func mounthLabel(fontSize size: Int, color: UIColor, scale: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: CGFloat(size))
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = scale
        label.textColor = color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension UILabel {
    convenience init(fontSize size: Int, color: UIColor, weight: UIFont.Weight) {
        self.init()
        self.font = .systemFont(ofSize: CGFloat(size), weight: weight)
        self.textAlignment = .left
        self.textColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
