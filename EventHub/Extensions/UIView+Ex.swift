//
//  UIView+Ex.swift
//  EventHub
//
//  Created by user on 25.11.2024.
//

import UIKit

extension UIView {
    func addViews(_ view: UIView...){
        view.forEach { addSubview($0)}
    }
}
