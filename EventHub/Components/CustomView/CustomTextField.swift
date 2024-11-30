//
//  CustomTextField.swift
//  EventHub
//
//  Created by user on 25.11.2024.
//

import UIKit

enum CustomTextFieldType {
    case userName
    case email
    case password
    case confirmPassword
}

enum TextFieldImageSide {
    case left
    case right
}

final class CustomTextField: UITextField {
    
    //MARK: - Private Property
    private let authFieldType: CustomTextFieldType
    
    private var eyeButton: UIButton?
    
    
    //MARK: - Init
    init(authFieldType: CustomTextFieldType, isPrivate: Bool = false) {
        self.authFieldType = authFieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        
        
        if isPrivate {
            isSecureTextEntry = true
            
            setupEyeButton()
        }
        
        switch authFieldType {
        case .userName:
            self.placeholder = "Full name"
        case .email:
            self.placeholder = "Your Email"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Your Password"
        case .confirmPassword:
            self.placeholder = "Confirm password"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEyeButton() {
        eyeButton = UIButton(type: .custom)
        eyeButton?.setImage(
            UIImage(named: "eyeClose"),
            for: .normal
        )
        eyeButton?.setImage(
            UIImage(named: "eyeClose"),
            for: .selected
        )
        
        eyeButton?.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        eyeButton?.translatesAutoresizingMaskIntoConstraints = false
        eyeButton?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        eyeButton?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        rightView = eyeButton
        rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        eyeButton?.isSelected.toggle()
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 10
        return rect
    }
}


extension CustomTextField {
    func setUpImage(imageName: String, on side: TextFieldImageSide) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 22, height: 22))
        if let imageWithSystemName = UIImage(systemName: imageName) {
            imageView.image = imageWithSystemName
            imageView.tintColor = .gray
        } else {
            imageView.image = UIImage(named: imageName)
        }
        
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        imageContainerView.addSubview(imageView)
        
        switch side {
        case .left:
            leftView = imageContainerView
            leftViewMode = .always
        case .right:
            rightView = imageContainerView
            rightViewMode = .always
        }
    }
}
