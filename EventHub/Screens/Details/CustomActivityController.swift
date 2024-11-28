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
    
//    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let sheet = sheetPresentationController {
                sheet.detents = [.custom { _ in return UIScreen.main.bounds.height / 2.5 }]
                sheet.preferredCornerRadius = 38
            }
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.view.viewWithTag(777)?.removeFromSuperview()
    }
    
//    MARK: - SetupUI
    
    private func SetupUI() {
        view.backgroundColor = .systemBackground
        view.addSubviews(topLineView, shareLabel)
        setupConstraints()
    }
    
//    MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            topLineView.heightAnchor.constraint(equalToConstant: 3),
            topLineView.widthAnchor.constraint(equalToConstant: 35),
            
            shareLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            shareLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35)
        ])
    }
}

#Preview {
    CustomActivityController()
}
