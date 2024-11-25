//
//  EventCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
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
        imageView.isUserInteractionEnabled = true
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
    
    private let locationCell: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    дата на imageView
    private let dateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0.7
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "12"
        label.textColor = .AccentOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mounthLabel: UILabel = {
        let label = UILabel()
        label.text = "June"
        label.textColor = .AccentOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    mark favorite
    
    private let favoriteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0.7
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmark")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var isFavorite: Bool = false {
        didSet {
            favoriteIcon.image = UIImage(named: isFavorite ? "bookmark" : "bookmarkFill")
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor.green.cgColor
                print("tap on cell \(titleCell.text!)")
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
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
    
    // MARK: - Actions
    
    @objc private func toggleFavorite() {
        isFavorite.toggle()
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = mainView.bounds.width / 10
        imageViewCell.layer.cornerRadius = 20
    }
    
    private func setupUI() {
        contentView.addSubview(mainView)
        [
            imageViewCell,
            titleCell,
            locationCell
        ]
            .forEach {mainView.addSubview($0)}
        imageViewCell.addSubview(dateContainerView)
        imageViewCell.addSubview(favoriteView)
        dateContainerView.addSubview(dateLabel)
        dateContainerView.addSubview(mounthLabel)
        favoriteView.addSubview(favoriteIcon)
        
        tapedFavorite()
    }
    
    private func tapedFavorite() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleFavorite))
        favoriteView.addGestureRecognizer(tapRecognizer)
        favoriteView.isUserInteractionEnabled = true
    }
    
    func configureCell(imageName: String, title: String, location: String) {
        imageViewCell.image = UIImage(named: imageName)
        imageViewCell.layer.cornerRadius = 10
        titleCell.text = title
        locationCell.text = location
    }
}

extension EventCollectionViewCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageViewCell.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 9),
            imageViewCell.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 9),
            imageViewCell.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -9),
            imageViewCell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleCell.topAnchor.constraint(equalTo: imageViewCell.bottomAnchor, constant: 5),
            titleCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            locationCell.topAnchor.constraint(equalTo: titleCell.bottomAnchor, constant: 10),
            locationCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
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
            favoriteView.heightAnchor.constraint(equalToConstant: 30),
            
            favoriteIcon.centerYAnchor.constraint(equalTo: favoriteView.centerYAnchor),
            favoriteIcon.centerXAnchor.constraint(equalTo: favoriteView.centerXAnchor)
        ])
    }
}
  
