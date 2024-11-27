//
//  DetailsView.swift
//  EventHub
//
//  Created by Олег Дербин on 22.11.2024.
//

import UIKit
import Kingfisher

protocol DetailsViewProtocol: AnyObject {
    func backButtonTapped()
}

final class DetailsView: UIView {
    weak var delegate: DetailsViewProtocol?
    
//    MARK: UI Elements
    
     let customNavBar: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(resource: .customNav)
        return $0
    }(UIImageView())
    
    private let backButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(resource: .back), for: .normal)
        return $0
    }(UIButton())
    
      let navBarLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Event Details"
        $0.textColor = .white
          $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return $0
    }(UILabel())
    
    private let bookmarkButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(resource: .bookmark), for: .normal)
        return $0
    }(UIButton())
    
    let shareButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(resource: .share), for: .normal)
        return $0
    }(UIButton())
    
    let infoTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
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
    
    @objc func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
//MARK: - SetupUI
    private func setupUI() {
        self.backgroundColor = .white
        addSubviews(
            customNavBar,
            backButton,
            navBarLabel,
            bookmarkButton,
            shareButton,
            infoTableView
        )
        setupConstraints()
        setupTargets()
    }
    
    func setNavBar(model: Event) {
        customNavBar.kf.setImage(
            with: URL(string: model.images?.first?.imageUrl ?? ""),
            placeholder: UIImage(named: "CustomNav")
        )
    }
    
    //MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            customNavBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.27),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -5),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            
            navBarLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 5),
            navBarLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bookmarkButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -5),
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
    
    func setupTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
}
