//
//  TestViewCell.swift
//  EventHub
//
//  Created by nikita on 19.11.24.
//

import UIKit
import Kingfisher

final class TestCell: UICollectionViewCell {
    private let eventImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let eventTitle = UILabel()
    private let eventDateStart = UILabel()
    private let eventDateEnd = UILabel()
    private let placeName = UILabel()
    private let placeLoaction = UILabel()
    private let placeLatitude = UILabel()
    private let placeLongitude = UILabel()
    
    private let participantImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private let participantName = UILabel()
    private let participantRole = UILabel()
    
    private let aboutEvent: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
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
        eventImageView.kf.setImage(
            with: URL(string: event.images?.first?.imageUrl ?? ""),
            placeholder: UIImage(systemName: "photo")
        )
        eventTitle.text = "event title: " + (event.title ?? "empty")
        eventDateStart.text = "eventDateStart: " + String(describing: event.eventDate?.last?.start ?? 0)
        eventDateEnd.text = "eventDateEnd: " + String(describing: event.eventDate?.last?.end ?? 0)
        placeName.text = "placeName: " + (event.place?.title ?? "empty")
        placeLoaction.text = "placeLoaction: " + (event.place?.address ?? "empty")
        placeLatitude.text = "placeLatitude: " + String(event.place?.coords?.lat ?? 0.0)
        placeLongitude.text = "placeLongitude: " + String(describing: event.place?.coords?.lon ?? 0.0)
        participantImageView.kf.setImage(
            with: URL(string: event.participants?.first?.agent?.image?.first?.imageUrl ?? ""),
            placeholder: UIImage(systemName: "person.fill")
        )
        participantName.text = "agent: " + (event.participants?.first?.agent?.title ?? "empty")
        participantRole.text = "role: " + (event.participants?.first?.role?.name ?? "empty")
        aboutEvent.text = "about event:\n" + (event.text ?? "empty")
    }
}

private extension TestCell {
    func setupViews() {
        [
            eventImageView,
            eventTitle,
            eventDateStart,
            eventDateEnd,
            placeName,
            placeLoaction,
            placeLatitude,
            placeLongitude,
            participantImageView,
            participantName,
            participantRole,
            aboutEvent
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
            eventImageView.heightAnchor.constraint(equalToConstant: 150),
            
            eventTitle.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 8),
            eventTitle.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            eventTitle.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            eventTitle.heightAnchor.constraint(equalToConstant: 16),
            
            eventDateStart.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 8),
            eventDateStart.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            eventDateStart.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            eventDateStart.heightAnchor.constraint(equalToConstant: 16),
            
            eventDateEnd.topAnchor.constraint(equalTo: eventDateStart.bottomAnchor, constant: 8),
            eventDateEnd.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            eventDateEnd.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            eventDateEnd.heightAnchor.constraint(equalToConstant: 16),
            
            placeName.topAnchor.constraint(equalTo: eventDateEnd.bottomAnchor, constant: 8),
            placeName.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            placeName.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            placeName.heightAnchor.constraint(equalToConstant: 16),
            
            placeLoaction.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 8),
            placeLoaction.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            placeLoaction.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            placeLoaction.heightAnchor.constraint(equalToConstant: 16),
            
            placeLatitude.topAnchor.constraint(equalTo: placeLoaction.bottomAnchor, constant: 8),
            placeLatitude.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            placeLatitude.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            placeLatitude.heightAnchor.constraint(equalToConstant: 16),
            
            placeLongitude.topAnchor.constraint(equalTo: placeLatitude.bottomAnchor, constant: 8),
            placeLongitude.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            placeLongitude.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            placeLongitude.heightAnchor.constraint(equalToConstant: 16),
            
            participantImageView.topAnchor.constraint(equalTo: placeLongitude.bottomAnchor, constant: 8),
            participantImageView.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            participantImageView.heightAnchor.constraint(equalToConstant: 40),
            
            participantName.topAnchor.constraint(equalTo: participantImageView.bottomAnchor, constant: 8),
            participantName.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            participantName.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            participantName.heightAnchor.constraint(equalToConstant: 16),
            
            participantRole.topAnchor.constraint(equalTo: participantName.bottomAnchor, constant: 8),
            participantRole.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            participantRole.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
            participantRole.heightAnchor.constraint(equalToConstant: 16),
            
            aboutEvent.topAnchor.constraint(equalTo: participantRole.bottomAnchor, constant: 8),
            aboutEvent.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor),
            aboutEvent.trailingAnchor.constraint(equalTo: eventImageView.trailingAnchor),
        ])
    }
}
