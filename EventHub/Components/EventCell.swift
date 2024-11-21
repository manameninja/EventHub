//
//  EventCell.swift
//  EventHub
//
//  Created by nikita on 21.11.24.
//

import UIKit

import UIKit
import Kingfisher

final class EventCell: UICollectionViewCell {
    private let eventImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .primaryBlue
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .typographyBlack
        label.numberOfLines = 2
        return label
    }()
    
    private let addressImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "mappin.and.ellipse")
        return view
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .typographyGray
        return label
    }()
    
    private let favoriteButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "bookmark")
        config.baseBackgroundColor = .systemBackground
        config.baseForegroundColor = .accentRed
        let button = UIButton(configuration: config)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with event: Event) {
        
    }
}

private extension EventCell {
    func setupViews() {
        [
            eventImageView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            eventImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            eventImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
