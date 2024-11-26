//
//  ButtonGoogle.swift
//  EventHub
//
//  Created by user on 25.11.2024.
//

import UIKit

final class ButtonGoogle: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setupButton(title)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ButtonGoogle {
    private func setupButton(_ title: String ) {
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = false
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        
        let buttonImage = UIImageView(image: UIImage(named: "googleIcon"))
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonImage)
        
        NSLayoutConstraint.activate([
            buttonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            buttonImage.widthAnchor.constraint(equalToConstant: 30),
            buttonImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        layer.shadowColor = UIColor.shadowLight.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
    }
}
