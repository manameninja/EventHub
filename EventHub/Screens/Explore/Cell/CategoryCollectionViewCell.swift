//
//  CategoryCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 24.11.2024.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = CategoryCollectionViewCell.description()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = CategoryImage.music
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let categoryLabel = UILabel(fontSize: 15, color: .white, weight: .medium)
    
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
        contentView.addSubview(logoImageView)
        contentView.addSubview(categoryLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = ""
    }
    
    func configureCell(category: String, index: Int) {
        layer.shadowColor = UIColor(hexString: "2E2E4F", alpha: 1.0)?.cgColor
        layer.shadowOpacity = 0.02
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 25
        categoryLabel.text = category
        
        let images = [
            CategoryImage.food,
            CategoryImage.game,
            CategoryImage.music
        ]
        logoImageView.image = images[index % images.count]
    }
    
    // MARK: - Constraints
    private func setContstraints() {
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
