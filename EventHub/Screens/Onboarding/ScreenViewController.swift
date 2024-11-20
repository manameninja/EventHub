//
//  ScreenViewController.swift
//  EventHub
//
//  Created by Олег Дербин on 18.11.2024.
//

import UIKit

class ScreenViewController: UIViewController {
    
    //    MARK: - UI Elements
    
    private let screenImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    //    MARK: - Init
    
    init(with helper: OnboardingHelper) {
        super.init(nibName: nil, bundle: nil)
        screenImage.image = helper.image
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - SetupUI
    
    private func setupUI() {
        view.addSubview(screenImage)
        setupConstraints()
        animateBottomViewAppearance()
    }
    
    //    MARK: - Setup Constraints
    
    private func setupConstraints() {
        screenImage.transform = CGAffineTransform(translationX: 0, y: -200)
        NSLayoutConstraint.activate([
            screenImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -130),
            screenImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            screenImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            
        ])
    }
    
    private func animateBottomViewAppearance() {
        UIView.animate(withDuration: 1) {
            self.screenImage.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    
}
