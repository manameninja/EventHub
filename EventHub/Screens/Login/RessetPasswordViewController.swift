//
//  RessetPassword.swift
//  EventHub
//
//  Created by user on 21.11.2024.
//

import UIKit

final class RessetPasswordViewController: UIViewController {
    
    private let emailField = CustomTextField(authFieldType: .email)
    private let sendButton = CustomButton(title: "SEND", hasBackground: true, fontSize: .big)
    private let labelTitle = UILabel.makeLabel(text: "Please enter your address to request a password reset", font: .systemFont(ofSize: 16), textColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
}

extension RessetPasswordViewController {
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
    }
    
    func addSubviews() {
        view.addViews(
            emailField,
            sendButton,
            labelTitle
        )
    }
}


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
            sendButton.widthAnchor.constraint(equalToConstant: 271)
            
            
        ])
    }
}
