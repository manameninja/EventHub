//
//  FavoritesButton.swift
//  EventHub
//
//  Created by Даниил Павленко on 19.11.2024.
//

import UIKit

final class FavoritesButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
            configure()
        }
    }
    
    func configure() {
        layer.zPosition = 1
        adjustsImageWhenHighlighted = false
        
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "bookmark"), for: .normal)
        tintColor = .white
        backgroundColor = .primaryBlue
        
        layer.shadowColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    
}
