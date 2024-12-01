//
//  CustomTabBar.swift
//  EventHub
//
//  Created by Даниил Павленко on 19.11.2024.
//

import UIKit

class CustomTabBar: UITabBar {
    
    public let favoritesButton = FavoritesButton()
    private let shapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        configureShape()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        tintColor = .primaryBlue
        unselectedItemTintColor = .typographyGray3
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            configureShape()
        }
    }
}

extension CustomTabBar {
    
    private func configureShape() {
        let path = getTabBarPath()
        shapeLayer.path = path.cgPath // Обновляем существующий слой
        shapeLayer.fillColor = UIColor.systemBackground.cgColor
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOpacity = 0.1
        shapeLayer.shadowRadius = 8
        shapeLayer.shadowOffset = CGSize(width: 0, height: -3)
        
        // Добавляем или заменяем подслой только один раз
        if layer.sublayers?.contains(shapeLayer) == false {
            layer.insertSublayer(shapeLayer, at: 0)
        }
    }
    
    private func getTabBarPath() -> UIBezierPath {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()
        
        return path
    }
}
