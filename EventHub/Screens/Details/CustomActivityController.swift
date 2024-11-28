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
        view.addSubview(topLineView)
        setupConstraints()
    }
    
//    MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            topLineView.heightAnchor.constraint(equalToConstant: 3),
            topLineView.widthAnchor.constraint(equalToConstant: 35),
        ])
    }
}

#Preview {
    CustomActivityController()
}
