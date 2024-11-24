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
    
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        backgroundColor = hasBackground ? .systemBlue : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .systemBlue
        setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            //надо апееркейс добавить
        case .med:
            titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        case .small:
            titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
