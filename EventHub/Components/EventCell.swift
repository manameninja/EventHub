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
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "date Label"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .primaryBlue
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name Label strole1 \n stroke2"
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
        label.text = "address Label"
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
        //MARK: - setup event photo
        eventImageView.kf.setImage(
            with: URL(string: event.images?.first?.imageUrl ?? ""),
            placeholder: UIImage(systemName: "photo")
        )
        
        //MARK: - setup event date
        var nextDate: Int? = event.eventDate?.last?.start
        
        for date in event.eventDate ?? [] {
            if date.start ?? 0 > Int(Date().timeIntervalSince1970) {
                nextDate = date.start
                break
            }
        }
        
        if let unixTime = nextDate {
            let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, MMM d • h:mm a"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text = formattedDate
        } else {
            dateLabel.text = "Date and time unknown"
        }
        
        //MARK: - setup event name
        nameLabel.text = event.title
        
        //MARK: - setup event address
        addressLabel.text = event.place?.address
    }
}

private extension EventCell {
    func setupViews() {
        backgroundColor = .systemBackground
        
        [
            eventImageView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            eventImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            eventImageView.widthAnchor.constraint(equalToConstant: 79),
            
            
        ])
    }
}
