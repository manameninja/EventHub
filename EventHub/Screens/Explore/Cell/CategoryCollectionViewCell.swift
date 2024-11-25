//
//  CategoryCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 24.11.2024.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    private let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 25
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "food")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Food"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        setContstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        contentView.addSubview(mainView)
        [
            logoImageView,
            categoryLabel
        ].forEach {mainView.addSubview($0)}
    }
    
    func configureCell(category: String) {
        categoryLabel.text = category
    }
    
    private func setContstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            mainView.widthAnchor.constraint(equalToConstant: 106),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 17),
            logoImageView.widthAnchor.constraint(equalToConstant: 17),
            logoImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            logoImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            categoryLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }
}
