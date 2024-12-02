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
    
    func configureCell(category: String, imageName: String) {
        layer.shadowColor = UIColor(hexString: "2E2E4F", alpha: 1.0)?.cgColor
        layer.shadowOpacity = 0.02
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 25
        categoryLabel.text = category

        logoImageView.image = getCategoryImage(from: imageName)
        logoImageView.tintColor = .white
    }
    
    func getCategoryImage(from slug: String) -> UIImage? {
        switch slug.lowercased() {
        case "cinema":
            return CategoryImage.cinema.image
        case "concert":
            return CategoryImage.concert.image
        case "education":
            return CategoryImage.education.image
        case "entertainment":
            return CategoryImage.entertainment.image
        case "exhibition":
            return CategoryImage.exhibition.image
        case "fashion":
            return CategoryImage.fashion.image
        case "festival":
            return CategoryImage.festival.image
        case "holiday":
            return CategoryImage.holiday.image
        case "kids":
            return CategoryImage.kids.image
        case "other":
            return CategoryImage.other.image
        case "party":
            return CategoryImage.party.image
        case "photo":
            return CategoryImage.photo.image
        case "quest":
            return CategoryImage.quest.image
        case "recreation":
            return CategoryImage.recreation.image
        case "shopping":
            return CategoryImage.shopping.image
        case "stock":
            return CategoryImage.stock.image
        case "theater":
            return CategoryImage.theater.image
        case "tour":
            return CategoryImage.tour.image
        default:
            return UIImage(named: "game")
        }
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
