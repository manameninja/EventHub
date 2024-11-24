//
//  Button.swift
//  EventHub
//
//  Created by user on 18.11.2024.
//

import UIKit

final class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize, hasImage: Bool = false) {
        super.init(frame: .zero)
        
        setupButton(title, hasBackground, fontSize, hasImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CustomButton {
    private func setupButton(_ title: String, _ hasBackground: Bool, _ fontSize: FontSize, _ hasImage: Bool) {
        
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = false
        
        
        layer.shadowColor = UIColor.addShadowDark.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        
        if hasImage {
            
            let buttonImage = UIImageView(image: UIImage(named: "arrow"))
            buttonImage.translatesAutoresizingMaskIntoConstraints = false
            addSubview(buttonImage)
            
            NSLayoutConstraint.activate([
                buttonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                buttonImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                buttonImage.widthAnchor.constraint(equalToConstant: 30),
                buttonImage.heightAnchor.constraint(equalToConstant: 30)
            ])
            
        }
        
        
        backgroundColor = hasBackground ? .systemBlue : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .systemBlue
        setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        case .med:
            titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        case .small:
            titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }
}

