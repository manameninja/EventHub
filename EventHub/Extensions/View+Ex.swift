//
//  View+Ex.swift
//  EventHub
//
//  Created by Олег Дербин on 22.11.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
