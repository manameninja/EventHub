//
//  CustomActivityController.swift
//  EventHub
//
//  Created by Олег Дербин on 28.11.2024.
//

import UIKit

class CustomActivityController: UIViewController {
    //    MARK: - UIElements
    
    private let topLineView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(resource: .rectangle)
        $0.contentMode = .center
        return $0
    }(UIImageView())
    
    private let shareLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Share with friends"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        $0.textColor = UIColor.label
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let copyLinkButton = CustomButtonAC(
        image: UIImage(resource: .copyLink),
        title: "CopyLink",
        colorShadow: "#9B9CA8"
    )
    private let watsappButton = CustomButtonAC(
        image: UIImage(resource: .watsapp),
        title: "Watsapp",
        colorShadow: "#3DC04F"
    )
    private let facebookButton = CustomButtonAC(
        image: UIImage(
            resource: .facebook
        ),
        title: "Facebook",
        colorShadow: "#0672E7"
    )
    private let messengerButton = CustomButtonAC(
        image: UIImage(
            resource: .messenger
        ),
        title: "Messenger",
        colorShadow: "7B48FF"
    )
    private let twitterButton = CustomButtonAC(
        image: UIImage(
            resource: .twitter
        ),
        title: "Twitter",
        colorShadow: "10A1FF"
    )
    private let instagramButton = CustomButtonAC(
        image: UIImage(resource: .instagram),
        title: "Instagram",
        colorShadow: "406ADC"
    )
    private let skypeButton = CustomButtonAC(
        image: UIImage(resource: .skype),
        title: "Skype",
        colorShadow: "1D7FD8"
    )
    private let messageButton = CustomButtonAC(
        image: UIImage(resource: .message),
        title: "Message",
        colorShadow: "1DC536"
    )
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor.systemGray5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stackView: UIStackView = {
        $0.axis = .horizontal
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private let stackViewTwo: UIStackView = {
        $0.axis = .horizontal
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 16.0, *) {
            if let sheet = sheetPresentationController {
                let screenHeight = UIScreen.main.bounds.height
                if screenHeight <= 667 {
                    sheet.detents = [.custom { _ in return screenHeight / 1.8 }]
                } else {
                    sheet.detents = [.custom { _ in return screenHeight / 2.5 }]
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.view.viewWithTag(777)?.removeFromSuperview()
    }
    
    //    MARK: - SetupUI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(topLineView, shareLabel, stackView, stackViewTwo, cancelButton)
        stackView
            .addArrangedSubviews(
                views: copyLinkButton,
                watsappButton,
                facebookButton,
                messengerButton
            )
        stackViewTwo
            .addArrangedSubviews(views: twitterButton, instagramButton, skypeButton, messageButton)
        setupConstraints()
        setupButtonActions()
    }
    
    //    MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            topLineView.heightAnchor.constraint(equalToConstant: 3),
            topLineView.widthAnchor.constraint(equalToConstant: 35),
            
            shareLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            shareLabel.topAnchor.constraint(equalTo: topLineView.topAnchor, constant: 35),
            
            stackView.topAnchor.constraint(equalTo: shareLabel.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackViewTwo.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackViewTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: stackViewTwo.bottomAnchor,constant: 15),
            cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 65)
            
        ])
    }
    
}

extension CustomActivityController {
    
    //MARK: - Add Action
    
    private func setupButtonActions() {
        cancelButton.addAction(UIAction { _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
    }
}

