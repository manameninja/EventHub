//
//  EventCell.swift
//  EventHub
//
//  Created by nikita on 21.11.24.
//

import UIKit

import UIKit
import Kingfisher

protocol EventCellDelegate: AnyObject {
    func didTapButton(in cell: EventCell)
}

final class EventCell: UICollectionViewCell {
    weak var delegate: EventCellDelegate?
        
    private let eventImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .primaryBlue
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .typographyBlack
        label.numberOfLines = 2
        return label
    }()
    
    private let addressImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = .mapPin
        return view
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .typographyGray
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(systemName: "bookmark")
        button.imageView?.contentMode = .scaleToFill
        button.tintColor = .accentRed
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        imageURL: URL?,
        isFavorite: Bool,
        date: String,
        title: String,
        address: String
    ) {
        eventImageView.kf.setImage(with: imageURL)
        dateLabel.text = date
        titleLabel.text = title
        addressLabel.text = address
        makeFavorite(isFavorite)
    }
    
    func makeFavorite(_ state: Bool) {
        favoriteButton.setImage(
            UIImage(systemName: state ? "bookmark.fill" : "bookmark"),
            for: .normal
        )
    }
    
    @objc func favoriteTapped() {
        delegate?.didTapButton(in: self)
    }
}

private extension EventCell {
    func setupViews() {
        backgroundColor = .systemBackground
        [
            eventImageView,
            favoriteButton,
            dateLabel,
            titleLabel,
            addressImageView,
            addressLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        contentView.layer.cornerRadius = 10
                contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 16
        
        layer.shadowColor = UIColor.backgroundShadow.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 10
        layer.masksToBounds = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            eventImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            eventImageView.widthAnchor.constraint(equalToConstant: 79),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            favoriteButton.heightAnchor.constraint(equalToConstant: 17),
            favoriteButton.widthAnchor.constraint(equalToConstant: 17),
            
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 18),
            dateLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: 17),
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 36),
            
            addressImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 11),
            addressImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addressImageView.heightAnchor.constraint(equalToConstant: 17),
            addressImageView.widthAnchor.constraint(equalToConstant: 17),
            
            addressLabel.topAnchor.constraint(equalTo: addressImageView.topAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: addressImageView.trailingAnchor, constant: 6),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addressLabel.bottomAnchor.constraint(equalTo: addressLabel.bottomAnchor)
        ])
    }
    
    func setupTargets() {
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
}
