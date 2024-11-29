//
//  ProfileView.swift
//  EventHub
//
//  Created by Даниил Павленко on 29.11.2024.
//

import UIKit

final class ProfileView: UIView {
    
//MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius =  imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ivan Ivanov"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = "About Me"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .typographyBlack2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        let text = "Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More"
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .typographyBlack2
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
        
        return label
    }()
    
    private let editButton: UIButton = {
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
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.primaryBlue.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let logoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logout")
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
        
        backgroundColor = .systemBackground
        
        setupUI()
        setupConstraints()
//        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - SetupUI

extension ProfileView {
    
    func setupUI() {
        backgroundColor = .systemBackground
        [
            titleLabel,
            profileImageView,
            nameLabel,
            editButton,
            aboutMeLabel,
            descriptionLabel,
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
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: (superview?.frame.width ?? 375) * 0.27),
            profileImageView.heightAnchor.constraint(equalToConstant: (superview?.frame.width ?? 375) * 0.27),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            editImageView.leadingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: 20),
            editImageView.topAnchor.constraint(equalTo: editButton.topAnchor, constant: 15),
            editImageView.bottomAnchor.constraint(equalTo: editButton.bottomAnchor, constant: -15),
            editImageView.heightAnchor.constraint(equalToConstant: 22),
            editImageView.widthAnchor.constraint(equalToConstant: 22),
            
            editLabel.leadingAnchor.constraint(equalTo: editImageView.trailingAnchor, constant: 20),
            editLabel.trailingAnchor.constraint(equalTo: editButton.trailingAnchor, constant: -20),
            editLabel.centerYAnchor.constraint(equalTo: editButton.centerYAnchor),
            
            aboutMeLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 50),
            aboutMeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 50),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            logoutImageView.heightAnchor.constraint(equalToConstant: 28),
            logoutImageView.widthAnchor.constraint(equalToConstant: 28),
            logoutImageView.leadingAnchor.constraint(equalTo: logoutButton.leadingAnchor),
            logoutImageView.topAnchor.constraint(equalTo: logoutButton.topAnchor),
            logoutImageView.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor),
            
            logoutLabel.leadingAnchor.constraint(equalTo: logoutImageView.trailingAnchor, constant: 10),
            logoutLabel.trailingAnchor.constraint(equalTo: logoutButton.trailingAnchor),
            logoutLabel.centerYAnchor.constraint(equalTo: logoutButton.centerYAnchor),
        ])
    }
}
