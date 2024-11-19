//
//  NearbyCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit

class NearbyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
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
    
//    дата на imageView
    private let dateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .AccentOrange
        view.layer.opacity = 0.7
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mounthLabel: UILabel = {
        let label = UILabel()
        label.text = "June"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    mark favorite
    
    private let favoriteView: UIView = {
        let view = UIView()
        view.backgroundColor = .AccentOrange
        view.layer.opacity = 0.7
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setConstraint()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = mainView.bounds.width / 10
        imageViewCell.layer.cornerRadius = 20
    }
    
    private func setupUI() {
        contentView.addSubview(mainView)
        mainView.addSubview(imageViewCell)
        mainView.addSubview(titleCell)
        
        imageViewCell.addSubview(dateContainerView)
        imageViewCell.addSubview(favoriteView)
        
        dateContainerView.addSubview(dateLabel)
        dateContainerView.addSubview(mounthLabel)
        
    }
    
    func configureCell(imageName: String, title: String) {
        imageViewCell.image = UIImage(named: imageName)
        titleCell.text = title
    }
}

extension NearbyCollectionViewCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            imageViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            imageViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
            imageViewCell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleCell.topAnchor.constraint(equalTo: imageViewCell.bottomAnchor, constant: 5),
            titleCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            dateContainerView.topAnchor.constraint(equalTo: imageViewCell.topAnchor, constant: 8),
            dateContainerView.leadingAnchor.constraint(equalTo: imageViewCell.leadingAnchor, constant: 8),
            dateContainerView.heightAnchor.constraint(equalToConstant: 45),
            dateContainerView.widthAnchor.constraint(equalToConstant: 45),
            
            dateLabel.centerXAnchor.constraint(equalTo: dateContainerView.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: dateContainerView.topAnchor, constant: 2),
            
            mounthLabel.centerXAnchor.constraint(equalTo: dateContainerView.centerXAnchor),
            mounthLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            
            favoriteView.topAnchor.constraint(equalTo: imageViewCell.topAnchor, constant: 8),
            favoriteView.trailingAnchor.constraint(equalTo: imageViewCell.trailingAnchor, constant: -8),
            favoriteView.widthAnchor.constraint(equalToConstant: 30),
            favoriteView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
  
