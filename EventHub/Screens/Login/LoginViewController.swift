//
//  LoginViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    //MARK: - Private property
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let labelTitle = UILabel.makeLabel(text: "Sign In", font: .boldSystemFont(ofSize: 24), textColor: .typographyBlack)
    private let imageView = UIImageView()
    private let labelOR = UILabel.makeLabel(text: "OR", font: .systemFont(ofSize: 16), textColor: .typographyGray)
    private let labelQuestion = UILabel.makeLabel(text: "Don't have an account?", font: .systemFont(ofSize: 14), textColor: .typographyBlack)
    private let stackBottomLabel = UIStackView()
    
    private let rememberMeLabel = UILabel.makeLabel(text: "Remember me" ,font: .systemFont(ofSize: 14), textColor: .typographyBlack)
    private let switchRemember = UISwitch()
    private let stackRemember = UIStackView()
    
    private var emailField = CustomTextField(authFieldType: .email)
    private var passwordField = CustomTextField(authFieldType: .password, isPrivate: true)
    
    private let signInButton = CustomButton(title: "SIGN IN", hasBackground: true, fontSize: .big, hasImage: true)
    private let signUpButton = CustomButton(title: "Sign up", fontSize: .med)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    private let googleButton = ButtonGoogle(title: "Login with Google")
    var isCheck: Bool = false
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        setupView()
        setupLayout()
        setupSwitchButton()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapLoginGoogle), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if defaults.bool(forKey: "rememberMe") {
            emailField.text = defaults.string(forKey: "savedEmail")
            passwordField.text = defaults.string(forKey: "savedPassword")
            switchRemember.isOn = true
        } else {
            emailField.text = ""
            passwordField.text = ""
            switchRemember.isOn = false
        }
    }
    
    func setupSwitchButton() {
        switchRemember.onTintColor = .primaryBlue
        switchRemember.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        switchRemember.addTarget(self, action: #selector(didSwitchButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK: - Methods
    @objc private func didTapSignIn() {
        let loginRequest = LoginUserRequest(
            email: emailField.text ?? "",
            password: passwordField.text ?? ""
        )
        
        if !ValidatorManager.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        if !ValidatorManager.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    AlertManager.showSignInAlert(on: self!, with: error)
                    return
                }
                
                if let self = self {
                    if self.isCheck {
                        self.defaults.set(loginRequest.email, forKey: "savedEmail")
                        self.defaults.set(loginRequest.password, forKey: "savedPassword")
                        self.defaults.set(true, forKey: "rememberMe")
                    } else {
                        self.defaults.removeObject(forKey: "savedEmail")
                        self.defaults.removeObject(forKey: "savedPassword")
                        self.defaults.set(false, forKey: "rememberMe")
                    }
                    
                    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.checkAuthentication()
                    }
                }
            }
        }
    }
    
    @objc private func didSwitchButtonTapped() {
        isCheck = switchRemember.isOn
    }
    
    @objc private func didTapSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        print("didTapForgotPassword")
        let vc = RessetPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLoginGoogle() {
        print("didTapLoginGoogle")
        
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                print("Ошибка при авторизации через Google: \(error?.localizedDescription)")
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else  {
                print("Не удалось получить данные авторизации.")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Ошибка авторизации: \(error.localizedDescription)")
                    return
                }
                
                print("вход Google: \(authResult?.user.uid ?? "")")
                
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }
        }
    }
}


//MARK: - Settings
extension LoginViewController {
    func setupView() {
        view.backgroundColor = .color
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addViews(
            labelTitle,
            imageView,
            labelOR,
            stackBottomLabel,
            stackRemember,
            emailField,
            passwordField,
            signInButton,
            forgotPasswordButton,
            googleButton
        )
        
        settingsStackBottomLabel()
        settingsStackRemember()
        setupStackRemember()
        setupStackBottomLabel()
        setupTextFields()
        setupImage()
    }
    
    func setupTextFields() {
        self.emailField.setUpImage(imageName: "Mail", on: .left)
        self.passwordField.setUpImage(imageName: "Password", on: .left)
    }
    
    
    func setupImage() {
        imageView.image = UIImage(named: "Logo")
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 114).isActive = true
    }
    
    func settingsStackBottomLabel() {
        stackBottomLabel.addArrangedSubview(labelQuestion)
        stackBottomLabel.addArrangedSubview(signUpButton)
    }
    
    func settingsStackRemember() {
        stackRemember.addArrangedSubview(switchRemember)
        stackRemember.addArrangedSubview(rememberMeLabel)
    }
    
    func setupStackRemember() {
        stackRemember.axis = .horizontal
        stackRemember.alignment = .center
        stackRemember.spacing = 8
    }
    
    func setupStackBottomLabel() {
        stackBottomLabel.axis = .horizontal
        stackBottomLabel.alignment = .center
        stackBottomLabel.spacing = 4
    }
}


//MARK: - Setup Layout
extension LoginViewController {
    func setupLayout() {
        [
            scrollView,
            contentView,
            labelTitle,
            imageView,
            labelOR,
            stackBottomLabel,
            stackRemember,
            emailField,
            passwordField,
            signInButton,
            signUpButton,
            forgotPasswordButton,
            googleButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            labelTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            emailField.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 56),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 56),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            stackRemember.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            stackRemember.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            stackRemember.heightAnchor.constraint(equalToConstant: 30),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 24),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 30),
            signInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 58),
            signInButton.widthAnchor.constraint(equalToConstant: 271),
            
            labelOR.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30),
            labelOR.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelOR.heightAnchor.constraint(equalToConstant: 34),
            
            googleButton.topAnchor.constraint(equalTo: labelOR.bottomAnchor, constant: 40),
            googleButton.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: 58),
            googleButton.widthAnchor.constraint(equalToConstant: 271),
            
            stackBottomLabel.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 100),
            stackBottomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackBottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
        ])
    }
}
