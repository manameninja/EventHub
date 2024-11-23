//
//  DetailsView.swift
//  EventHub
//
//  Created by Олег Дербин on 22.11.2024.
//

import UIKit

class DetailsView: UIView {
    
//    MARK: UI Elements
    
    private let customNavBar: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
        return $0
    }(UIView())
    
    private let backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        return $0
    }(UIButton())
    
    private let navBarLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.text = "sdfsdfadfdsaf"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 30)
        return $0
    }(UILabel())
    
    private let bookmarkButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        return $0
    }(UIButton())
    
    private let shareButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        return $0
    }(UIButton())
    
    let infoTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .accentPurple
        return $0
    }(UITableView())
    
//    MARK: -Initializations
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - SetupUI
    private func setupUI() {
        addSubviews(
            customNavBar,
            backButton,
            navBarLabel,
            bookmarkButton,
            shareButton,
            infoTableView
        )
        setupConstraints()
    }
    
    //MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            customNavBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            navBarLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 5),
            navBarLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bookmarkButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 50),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 50),
            
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            shareButton.bottomAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: -5),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            
            infoTableView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 5),
            infoTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            infoTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            infoTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}

#Preview {
    DetailsView()
}
