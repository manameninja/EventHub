//
//  UIStackView+Ex.swift
//  EventHub
//
//  Created by Олег Дербин on 30.11.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(views: UIView...) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
