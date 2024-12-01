//
//  RessetPasswordViewController.swift
//  EventHub
//
//  Created by user on 25.11.2024.
//

import UIKit

final class RessetPasswordViewController: UIViewController {
    
    //MARK: - Private Property
    private let emailField = CustomTextField(authFieldType: .email)
    private let sendButton = CustomButton(title: "SEND", hasBackground: true, fontSize: .big, hasImage: true)
    private let labelTitle = UILabel.makeLabel(text: "Please enter your address to request a password reset", font: .systemFont(ofSize: 16), textColor: .typographyBlack)
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        
        let imageBack = UIImage(systemName: "arrow.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let backButton = UIBarButtonItem(image: imageBack, style: .plain, target: self, action: #selector(didTapBackButton))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Resset Password"
        
        sendButton.addTarget(self, action: #selector(didTapButtonSend), for: .touchUpInside)
    }
    
   //MARK: - Methods
    @objc private func didTapButtonSend() {
        print("Send button")
        let email = self.emailField.text ?? ""
        
        if !ValidatorManager.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showForgotPasswordAlert(on: self, with: error)
                return
            }
            AlertManager.showPasswordResetSend(on: self)
        }
    }
    
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Settings
extension RessetPasswordViewController {
    func setupView() {
        view.backgroundColor = .color
        addSubviews()
        setupTextFields()
    }
    
    func addSubviews() {
        view.addViews(
            emailField,
            sendButton,
            labelTitle
        )
    }
    
    func setupTextFields() {
        emailField.setUpImage(imageName: "Mail", on: .left)
    }
}

//MARK: - Setup layout
extension RessetPasswordViewController {
    func setupLayout() {
        [
            emailField,
            sendButton,
            labelTitle
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 63),
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emailField.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 26),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 56),
            
            sendButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 40),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 58),
            sendButton.widthAnchor.constraint(equalToConstant: 271),
            
        ])
    }
}

