//
//  CustomButton.swift
//  EventHub
//
//  Created by Олег Дербин on 28.11.2024.
//

import UIKit

class CustomButtonAC: UIButton {
    
    init(image: UIImage, title: String, colorShadow: String) {
        super.init(frame: .zero)
        setupStyle()
        self.setImage(image, for: .normal)
        self.setTitle(title, for: .normal)
        addShadowToImage(colorShadow: colorShadow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        var config = UIButton.Configuration.plain()
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var attributes = incoming
            attributes.font = UIFont.systemFont(ofSize: 13)
            attributes.foregroundColor = UIColor.label
            return attributes
        }
        config.imagePlacement = .top
        self.configuration = config
        self.translatesAutoresizingMaskIntoConstraints = false
        addTappedAnimation()
    }
    
    
    private func addShadowToImage(colorShadow: String) {
        imageView?.layer.shadowColor = UIColor(hexString: colorShadow)?.cgColor
        imageView?.layer.shadowOffset = CGSize(width: 0, height: 6)
        imageView?.layer.shadowRadius = 12
        imageView?.layer.shadowOpacity = 0.2
        imageView?.layer.masksToBounds = false
    }
    
    private func addTappedAnimation() {
        addAction(UIAction { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform.identity 
                })
            }
        }, for: .touchUpInside)
    }
    
}
