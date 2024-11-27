//
//  EventCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit
import Kingfisher

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
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    Going
    private let goingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatarSize: CGFloat = 24
    
    private let topAvatarImage: UIImageView = {
       let imageView = UIImageView()
//        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let middleAvatarImage: UIImageView = {
       let imageView = UIImageView()
//        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomAvatarImage: UIImageView = {
       let imageView = UIImageView()
//        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let goingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .blue
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // location
    private let locationCell: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .BackgroundGray
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
        label.text = "14"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .AccentOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mounthLabel: UILabel = {
        let label = UILabel()
        label.text = "June"
        label.font = .systemFont(ofSize: 14)
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
        
        topAvatarImage.layer.cornerRadius = avatarSize / 2
        topAvatarImage.layer.shadowColor = UIColor.gray.cgColor
        topAvatarImage.layer.shadowOpacity = 0.9
        topAvatarImage.layer.shadowOffset = CGSize(width: 1, height: 3)
        topAvatarImage.layer.shadowRadius = 3
        
        middleAvatarImage.layer.cornerRadius = avatarSize/2
        middleAvatarImage.layer.shadowColor = UIColor.gray.cgColor
        middleAvatarImage.layer.shadowOpacity = 0.9
        middleAvatarImage.layer.shadowOffset = CGSize(width: 1, height: 3)
        middleAvatarImage.layer.shadowRadius = 3
        
        bottomAvatarImage.layer.cornerRadius = avatarSize/2
        bottomAvatarImage.layer.shadowColor = UIColor.gray.cgColor
        bottomAvatarImage.layer.shadowOpacity = 0.9
        bottomAvatarImage.layer.shadowOffset = CGSize(width: 1, height: 3)
        bottomAvatarImage.layer.shadowRadius = 3
        
        imageViewCell.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topAvatarImage.image = nil
        middleAvatarImage.image = nil
        bottomAvatarImage.image = nil
        goingLabel.text = ""
    }
    
    private func setupUI() {
        contentView.addSubview(mainView)
        [
            imageViewCell,
            titleCell,
            locationCell,
            goingView
        ]
            .forEach {mainView.addSubview($0)}
        imageViewCell.addSubview(dateContainerView)
        imageViewCell.addSubview(favoriteView)
        dateContainerView.addSubview(dateLabel)
        dateContainerView.addSubview(mounthLabel)
        favoriteView.addSubview(favoriteIcon)
        [
            bottomAvatarImage,
            middleAvatarImage,
            topAvatarImage,
            goingLabel
        ].forEach { goingView.addSubview($0)}
        tapedFavorite()
    }
    
    private func tapedFavorite() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleFavorite))
        favoriteView.addGestureRecognizer(tapRecognizer)
        favoriteView.isUserInteractionEnabled = true
    }
    
    func configureCell(imageName: String, title: String, location: String, goingCount: Int) {
        if let url = URL(string: imageName) {
            imageViewCell.kf.setImage(with: url)
        }
        imageViewCell.layer.cornerRadius = 10
        titleCell.text = title
        
        if !location.isEmpty {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "map-pin")
            attachment.bounds = CGRect(x: 0, y: -3, width: 16, height: 16)
            let attributedString = NSMutableAttributedString(attachment: attachment)
            let text = NSAttributedString(string: " \(location)")
            attributedString.append(text)
            locationCell.attributedText = attributedString
        }
                
        if goingCount > 1 {
            topAvatarImage.image = UIImage(named: "woomen")
            bottomAvatarImage.image = UIImage(named: "woomen")
            middleAvatarImage.image = UIImage(named: "manbottom")
            goingLabel.text = "+\(goingCount) Going"
        } else if goingCount == 1 {
            topAvatarImage.image = UIImage(named: "woomen")
            goingLabel.text = "+\(goingCount) Going"
        } else {
            goingLabel.isHidden = true
        }
    }
}

// MARK: - Constraints
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
            titleCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            goingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            goingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            goingView.topAnchor.constraint(equalTo: titleCell.bottomAnchor, constant: 12),
            goingView.heightAnchor.constraint(equalToConstant: avatarSize),
            
            topAvatarImage.leadingAnchor.constraint(equalTo: goingView.leadingAnchor),
            topAvatarImage.centerYAnchor.constraint(equalTo: goingView.centerYAnchor),
            topAvatarImage.widthAnchor.constraint(equalToConstant: avatarSize),
            topAvatarImage.heightAnchor.constraint(equalToConstant: avatarSize),
            
            middleAvatarImage.leadingAnchor.constraint(equalTo: topAvatarImage.trailingAnchor, constant: -avatarSize/2.4),
            middleAvatarImage.centerYAnchor.constraint(equalTo: goingView.centerYAnchor),
            middleAvatarImage.widthAnchor.constraint(equalToConstant: avatarSize),
            middleAvatarImage.heightAnchor.constraint(equalToConstant: avatarSize),
            
            bottomAvatarImage.leadingAnchor.constraint(equalTo: middleAvatarImage.trailingAnchor, constant: -avatarSize/2.4),
            bottomAvatarImage.centerYAnchor.constraint(equalTo: goingView.centerYAnchor),
            bottomAvatarImage.widthAnchor.constraint(equalToConstant: avatarSize),
            bottomAvatarImage.heightAnchor.constraint(equalToConstant: avatarSize),
            
            goingLabel.leadingAnchor.constraint(equalTo: goingView.leadingAnchor, constant: avatarSize*2.4),
            goingLabel.centerYAnchor.constraint(equalTo: goingView.centerYAnchor),
            
            locationCell.topAnchor.constraint(equalTo: goingView.bottomAnchor, constant: 10),
            locationCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
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
            favoriteIcon.centerXAnchor.constraint(equalTo: favoriteView.centerXAnchor),
        ])
    }
}
  
