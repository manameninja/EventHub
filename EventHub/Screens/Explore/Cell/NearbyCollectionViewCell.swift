//
//  NearbyCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit

class NearbyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleCell: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        setupUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        contentView.addSubview(imageViewCell)
        contentView.addSubview(titleCell)
    }
    
    func configureCell(imageName: String, title: String) {
        imageViewCell.image = UIImage(named: imageName)
        titleCell.text = title
    }
}

extension NearbyCollectionViewCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            imageViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            imageViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
            imageViewCell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleCell.topAnchor.constraint(equalTo: imageViewCell.bottomAnchor, constant: 5),
            titleCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
}
  
