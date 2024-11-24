//
//  SignUpController.swift
//  EventHub
//
//  Created by user on 20.11.2024.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let nameField = CustomTextField(authFieldType: .userName)
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password)
    private let confirmPasswordField = CustomTextField(authFieldType: .confirmPassword)
    
    
    private let signUpButton = CustomButton(title: "SIGN UP", hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Sign In", fontSize: .med)
    
    private let googleButton = ButtonGoogle(title: "Login with Google")
    
    private let labelOR = UILabel.makeLabel(text: "OR", font: .systemFont(ofSize: 16), textColor: .systemGray)
    private let labelQuestion = UILabel.makeLabel(text: "Aleady have an account?", font: .systemFont(ofSize: 14), textColor: .black)
    private let stack = UIStackView()
    
    
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


extension SignUpViewController {
    func setupView() {
        view.backgroundColor = .white
        stack.addArrangedSubview(labelQuestion)
        stack.addArrangedSubview(signInButton)
        addSubviews()
        setupStack()
    }
    
    func addSubviews() {
        view.addViews(
            labelOR,
            stack,
            nameField,
            emailField,
            passwordField,
            confirmPasswordField,
            signUpButton,
            googleButton
        )
    }
    
    
    func setupStack() {
        stack.axis = .horizontal
        stack.spacing = 4
    }
}


extension SignUpViewController {
    func setupLayout() {
        [
            labelOR,
            stack,
            nameField,
            emailField,
            passwordField,
            confirmPasswordField,
            signInButton,
            signUpButton,
            googleButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
            
            
            nameField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 20),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameField.heightAnchor.constraint(equalToConstant: 56),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 56),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 56),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            confirmPasswordField.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 56),
            confirmPasswordField.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 38),
            signUpButton.widthAnchor.constraint(equalToConstant: 271),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 58),
            
            labelOR.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            labelOR.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelOR.heightAnchor.constraint(equalToConstant: 34),
            
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.heightAnchor.constraint(equalToConstant: 24),
            
            
            googleButton.topAnchor.constraint(equalTo: labelOR.bottomAnchor, constant: 40),
            googleButton.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: 58),
            
        ])
    }
}


