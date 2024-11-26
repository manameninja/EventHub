//
//  SignUpViewController.swift
//  EventHub
//
//  Created by user on 25.11.2024.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    //MARK: Private property
    private let nameField = CustomTextField(authFieldType: .userName)
    private let emailField = CustomTextField(authFieldType: .email)
    private let passwordField = CustomTextField(authFieldType: .password)
    private let confirmPasswordField = CustomTextField(authFieldType: .confirmPassword)
    
    
    private let signUpButton = CustomButton(title: "SIGN UP", hasBackground: true, fontSize: .big, hasImage: true)
    private let signInButton = CustomButton(title: "Sign In", fontSize: .med)
    
    private let googleButton = ButtonGoogle(title: "Login with Google")
    
    private let labelOR = UILabel.makeLabel(text: "OR", font: .systemFont(ofSize: 16), textColor: .systemGray)
    private let labelQuestion = UILabel.makeLabel(text: "Already have an account?", font: .systemFont(ofSize: 14), textColor: .black)
    private let stack = UIStackView()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        
        let imageBack = UIImage(systemName: "arrow.backward")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let backButton = UIBarButtonItem(image: imageBack, style: .plain, target: self, action: #selector(didTapBackButton))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Sign Up"
        
        setupView()
        setupLayout()
    }
    
    //MARK: - Methods
    @objc private func didTapSignIn() {
        print("didTapSignIn")
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    @objc func didTapSignUp() {
        let registerUserRequest = RegisterUserRequest(
            userName: nameField.text ?? "",
            email: emailField.text ?? "",
            password: passwordField.text ?? "",
            confirmPassword: confirmPasswordField.text ?? ""
        )
        
        if !ValidatorManager.isValidUserName(for: registerUserRequest.userName) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }

        if !ValidatorManager.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        if !ValidatorManager.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
    
   
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - Settings
extension SignUpViewController {
    func setupView() {
        view.backgroundColor = .white
        stack.addArrangedSubview(labelQuestion)
        stack.addArrangedSubview(signInButton)
        setupTextFields()
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
    
    func setupTextFields() {
        nameField.setUpImage(imageName: "Profile", on: .left)
        emailField.setUpImage(imageName: "Mail", on: .left)
        passwordField.setUpImage(imageName: "Password", on: .left)
        passwordField.setUpImage(imageName: "eyeClose", on: .right)
        confirmPasswordField.setUpImage(imageName: "Password", on: .left)
        confirmPasswordField.setUpImage(imageName: "eyeClose", on: .right)
    }
    
    
    func setupStack() {
        stack.axis = .horizontal
        stack.spacing = 4
    }
}

//MARK: - Setup layout
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
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 58),
            signUpButton.widthAnchor.constraint(equalToConstant: 271),
            
            labelOR.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
            labelOR.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelOR.heightAnchor.constraint(equalToConstant: 34),
            
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.heightAnchor.constraint(equalToConstant: 24),
            
            googleButton.topAnchor.constraint(equalTo: labelOR.bottomAnchor, constant: 40),
            googleButton.centerXAnchor.constraint(equalTo: signUpButton.centerXAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: 58),
            googleButton.widthAnchor.constraint(equalToConstant: 271),
            
        ])
    }
}
