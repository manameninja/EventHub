//
//  EventCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit
import Kingfisher

protocol EventCollectionViewCellDelegate: AnyObject {
    func didTapButton(in cell: EventCollectionViewCell)
}

final class EventCollectionViewCell: UICollectionViewCell {
    weak var delegate: EventCollectionViewCellDelegate?
    
    // MARK: - Properties
    static let identifier = EventCollectionViewCell.description()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleCell = UILabel(fontSize: 18, color: .black, weight: .bold)
    
    //    Going
    private let goingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private let goingLabel = LabelFactory.goingLabel(fontSize: 12, color: .blue)
    
    // location
    private let locationCell = LabelFactory.locationLabel(
        fontSize: 15,
        color: UIColor(hexString: "716E90", alpha: 1.0) ?? .label
    )
    
    //    date event
    private let dateContainerView = UIView(background: .white, opacity: 0.7)
    private let dateLabel = UILabel(fontSize: 14, color: .accentOrange, weight: .regular)
    private let mounthLabel = LabelFactory.mounthLabel(fontSize: 14, color: .accentOrange, scale: 0.5)
    
    //    mark favorite
    private let favoriteView = UIView(background: .white, opacity: 0.7)
    private let favoriteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = K.imageBookmark
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var isFavorite: Bool = false {
        didSet {
            favoriteIcon.image =  isFavorite ? K.imageBookmark : K.imageBookmarkFill
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
        delegate?.didTapButton(in: self)
    }
    
    // MARK: - Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = mainView.bounds.width / 10
        
        setShadowToImage(imageView: topAvatarImage, cornerRadius: K.avatarSize/2)
        setShadowToImage(imageView: middleAvatarImage, cornerRadius: K.avatarSize/2)
        setShadowToImage(imageView: bottomAvatarImage, cornerRadius: K.avatarSize/2)
        
        imageViewCell.layer.cornerRadius = 20
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topAvatarImage.image = nil
        middleAvatarImage.image = nil
        bottomAvatarImage.image = nil
        goingLabel.text = "..."
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
        ]
            .forEach { goingView.addSubview($0)}
        tapedFavorite()
        
        layer.shadowColor = UIColor(hexString: "505588", alpha: 1.0)?.cgColor
        layer.shadowOpacity = 0.06
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 30
        layer.masksToBounds = false
    }
    
    private func tapedFavorite() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleFavorite))
        favoriteView.addGestureRecognizer(tapRecognizer)
        favoriteView.isUserInteractionEnabled = true
    }
    
    private func setShadowToImage(imageView: UIImageView, cornerRadius radius: CGFloat) {
        imageView.layer.cornerRadius = radius
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOpacity = 0.1
        imageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        imageView.layer.shadowRadius = 3
        
    }
    
    private func dateFormater(event timestamp: Int) -> (day: Int, month: String ) {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
//        let monthIndex = calendar.component(.month, from: date)
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "en_US")
        dateFormater.dateFormat = "MMM"
//        let month = dateFormater.monthSymbols[monthIndex - 1]
        let month = dateFormater.string(from: date)
        return (day, month)
    }
    
    func configureCell(imageName: String, title: String, location: String, goingCount: Int, date: Int, makeFavorite: Bool) {
        if let url = URL(string: imageName) {
            imageViewCell.kf.setImage(with: url)
        }
        imageViewCell.layer.cornerRadius = 10
        titleCell.text = title
        
        dateLabel.text = String(dateFormater(event: date).day)
        mounthLabel.text = dateFormater(event: date).month.uppercased()
        
        if !location.isEmpty {
            let attachment = NSTextAttachment()
            attachment.image = K.imagePin
            attachment.bounds = CGRect(x: 0, y: -3, width: 16, height: 16)
            let attributedString = NSMutableAttributedString(attachment: attachment)
            let text = NSAttributedString(string: " \(location)")
            attributedString.append(text)
            locationCell.attributedText = attributedString
        }
        
        if goingCount > 1 {
            topAvatarImage.image = K.topAvatarImage
            bottomAvatarImage.image = K.bottomAvatarImage
            middleAvatarImage.image = K.middleAvatarImage
            goingLabel.text = "+\(goingCount) Going"
        } else if goingCount == 1 {
            topAvatarImage.image = K.topAvatarImage
            goingLabel.text = "+\(goingCount) Going"
        } else {
            goingLabel.isHidden = true
        }
        
        isFavorite = makeFavorite
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
            goingView.heightAnchor.constraint(equalToConstant: K.avatarSize),
            
            topAvatarImage.leadingAnchor.constraint(equalTo: goingView.leadingAnchor),
            topAvatarImage.centerYAnchor.constraint(equalTo: goingView.centerYAnchor),
            topAvatarImage.widthAnchor.constraint(equalToConstant: K.avatarSize),
            topAvatarImage.heightAnchor.constraint(equalToConstant: K.avatarSize),
            
            middleAvatarImage.leadingAnchor.constraint(equalTo: topAvatarImage.trailingAnchor, constant: -K.avatarSize/2.4),
            middleAvatarImage.centerYAnchor.constraint(equalTo: goingView.centerYAnchor),
            middleAvatarImage.widthAnchor.constraint(equalToConstant: K.avatarSize),
            middleAvatarImage.heightAnchor.constraint(equalToConstant: K.avatarSize),
            
            bottomAvatarImage.leadingAnchor.constraint(equalTo: middleAvatarImage.trailingAnchor, constant: -K.avatarSize/2.4),
            bottomAvatarImage.centerYAnchor.constraint(equalTo: goingView.centerYAnchor),
            bottomAvatarImage.widthAnchor.constraint(equalToConstant: K.avatarSize),
            bottomAvatarImage.heightAnchor.constraint(equalToConstant: K.avatarSize),
            
            goingLabel.leadingAnchor.constraint(equalTo: goingView.leadingAnchor, constant: 60),
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
            
            mounthLabel.leadingAnchor.constraint(equalTo: dateContainerView.leadingAnchor, constant: 2),
            mounthLabel.trailingAnchor.constraint(equalTo: dateContainerView.trailingAnchor, constant: -2),
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

// MARK: - Extension UIView
extension UIView {
    convenience init(background color: UIColor, opacity: Float) {
        self.init()
        self.backgroundColor = color
        self.layer.opacity = opacity
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
