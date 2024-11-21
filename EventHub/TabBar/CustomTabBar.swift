//
//  CustomTabBar.swift
//  EventHub
//
//  Created by Даниил Павленко on 19.11.2024.
//

import UIKit

class CustomTabBar: UITabBar {
    
    public let favoritesButton = FavoritesButton()
    
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
}

extension CustomTabBar {
    
    private func configureShape() {
        let path = getTabBarPath()
        let shape = CAShapeLayer()
        
        shape.path = path.cgPath
        shape.fillColor = UIColor.systemBackground.cgColor
        
        shape.shadowColor = UIColor.black.cgColor
        shape.shadowOpacity = 0.3
        shape.shadowRadius = 5
        shape.shadowOffset = CGSize(width: 0, height: 5)
        layer.insertSublayer(shape, at: 0)
        
    }
    
    private func getTabBarPath() -> UIBezierPath {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        
        
        return path
    }
}
