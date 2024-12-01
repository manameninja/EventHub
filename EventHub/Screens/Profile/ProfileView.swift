//
//  ProfileView.swift
//  EventHub
//
//  Created by Даниил Павленко on 29.11.2024.
//

import UIKit

protocol ProfileViewProtocol: AnyObject {
    func didTappedEditProfileButton()
    func didTappedLogoutButton()
    func didTappedBackButton()
    func didTappedNameEditButton()
    func didTappedAboutMeEditButton()
    func didTappedProfileImageButton()
}

class ProfileView: UIView {
    
    weak var delegate: ProfileViewProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    let backButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "arrow.backward")
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .label
        let button = UIButton(configuration: config)
        button.isHidden = true
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eric")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius =  50
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Text Text"
        textField.font = .systemFont(ofSize: 24)
        textField.isEnabled = false
        return textField
    }()
    
    let nameEditButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "edit")
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .label
        let button = UIButton(configuration: config)
        button.isHidden = true
        return button
    }()
    
    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = "About Me"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .typographyBlack2
        return label
    }()
    
    let aboutMeEditButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "edit")
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .label
        let button = UIButton(configuration: config)
        button.isHidden = true
        return button
    }()
    
    let aboutMeTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = "Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More"
        textView.font = .systemFont(ofSize: 18, weight: .light)
        textView.textColor = .typographyBlack2
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        if let attributedText = textView.attributedText {
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedText)
            mutableAttributedString.enumerateAttributes(in: NSRange(location: 0, length: mutableAttributedString.length), options: []) { (attributes, range, _) in
                var updatedAttributes = attributes
                if updatedAttributes[.paragraphStyle] == nil {
                    updatedAttributes[.paragraphStyle] = paragraphStyle
                    mutableAttributedString.setAttributes(updatedAttributes, range: range)
                }
            }
            textView.attributedText = mutableAttributedString
        }
        return textView
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.primaryBlue.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "edit")
        imageView.tintColor = .primaryBlue
        return imageView
    }()
    
    private let editLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Profile"
        label.textColor = .primaryBlue
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let logoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logout")
        imageView.tintColor = .typographyGray
        return imageView
    }()
    
    private let logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Out"
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUserData(photo: UIImage, name: String, description: String) {
        profileImageView.image = photo
        nameTextField.text = name
        aboutMeTextView.text = description
    }
    
    func setupDelegates(_ vc: ProfileViewProtocol) {
        delegate = vc
    }
    
    //MARK: - OBJC Methods
    @objc func editButtonTapped() {
        delegate?.didTappedEditProfileButton()
    }
    
    @objc func backButtonTapped() {
        delegate?.didTappedBackButton()
    }
    
    @objc func logoutButtonTapped() {
        delegate?.didTappedLogoutButton()
    }
    
    @objc func nameEditButtonTapped() {
        delegate?.didTappedNameEditButton()
    }
    
    @objc func aboutMeEditButtonTapped() {
        delegate?.didTappedAboutMeEditButton()
    }
    
    @objc func profileImageButtonTapped(gestureRecognizer: UITapGestureRecognizer) {
        if gestureRecognizer.view is UIImageView {
            delegate?.didTappedProfileImageButton()
        }
    }
    
}

//MARK: - SetupUI

extension ProfileView {
    
    func setupUI() {
        backgroundColor = .systemBackground
        [
            titleLabel,
            backButton,
            profileImageView,
            editButton,
            nameTextField,
            nameEditButton,
            aboutMeLabel,
            aboutMeEditButton,
            aboutMeTextView,
            logoutButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        editButton.addSubviews(editImageView)
        editButton.addSubviews(editLabel)
        logoutButton.addSubviews(logoutImageView)
        logoutButton.addViews(logoutLabel)
        [
            editImageView,
            editLabel,
            logoutImageView,
            logoutLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        let screenHeight = superview?.frame.size.height ?? 812
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: (superview?.frame.width ?? 375) * 0.27),
            profileImageView.heightAnchor.constraint(equalToConstant: (superview?.frame.width ?? 375) * 0.27),
            
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 15),
            nameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameTextField.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            nameEditButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 10),
            nameEditButton.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor),
            nameEditButton.heightAnchor.constraint(equalToConstant: 24),
            nameEditButton.widthAnchor.constraint(equalToConstant: 24),
            
            editButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            editImageView.leadingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: 20),
            editImageView.topAnchor.constraint(equalTo: editButton.topAnchor, constant: 15),
            editImageView.bottomAnchor.constraint(equalTo: editButton.bottomAnchor, constant: -15),
            editImageView.heightAnchor.constraint(equalToConstant: 22),
            editImageView.widthAnchor.constraint(equalToConstant: 22),
            
            editLabel.leadingAnchor.constraint(equalTo: editImageView.trailingAnchor, constant: 20),
            editLabel.trailingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: -20),
            editLabel.centerYAnchor.constraint(equalTo: editButton.centerYAnchor),
            
            aboutMeLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: screenHeight * 0.05),
            aboutMeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            aboutMeEditButton.leadingAnchor.constraint(equalTo: aboutMeLabel.trailingAnchor, constant: 10),
            aboutMeEditButton.centerYAnchor.constraint(equalTo: aboutMeLabel.centerYAnchor),
            aboutMeEditButton.heightAnchor.constraint(equalToConstant: 24),
            aboutMeEditButton.widthAnchor.constraint(equalToConstant: 24),
            
            aboutMeTextView.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: screenHeight * 0.05),
            aboutMeTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            aboutMeTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            aboutMeTextView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -20),
            
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            logoutImageView.heightAnchor.constraint(equalToConstant: 22),
            logoutImageView.widthAnchor.constraint(equalToConstant: 22),
            logoutImageView.leadingAnchor.constraint(equalTo: logoutButton.leadingAnchor),
            logoutImageView.topAnchor.constraint(equalTo: logoutButton.topAnchor),
            logoutImageView.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor),
            
            logoutLabel.leadingAnchor.constraint(equalTo: logoutImageView.trailingAnchor, constant: 10),
            logoutLabel.trailingAnchor.constraint(equalTo: logoutButton.trailingAnchor),
            logoutLabel.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor),
        ])
    }
    
    func setupTargets() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nameEditButton.addTarget(self, action: #selector(nameEditButtonTapped), for: .touchUpInside)
        aboutMeEditButton.addTarget(self, action: #selector(aboutMeEditButtonTapped), for: .touchUpInside)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageButtonTapped(gestureRecognizer:)))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
}
