//
//  EventsView.swift
//  EventHub
//
//  Created by nikita on 27.11.24.
//

import UIKit

enum EventsType: String {
    case upcoming = "UPCOMING"
    case past = "PAST EVENTS"
}

protocol EventsViewDelegate: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CustomSwitchDelegate {
    func didTappedExploreButton()
}

final class EventsView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Events"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private let eventsSwitch = CustomSwitch(
        frame: .zero,
        leftText: EventsType.upcoming.rawValue,
        rightText: EventsType.past.rawValue,
        selectedSideColor: .primaryBlue,
        unselectedSideColor: .typographyGray6,
        colorForBackground: .black.withAlphaComponent(0.0287),
        colorForThumb: .systemBackground,
        thumbShadowColor: .black.withAlphaComponent(0.1)
    )
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let noFavoritesView = UIView()
    
    private let noFavoritesImage: UIImageView = {
        let view = UIImageView()
        view.image = .noUpcomingEvent
        view.tintColor = .red
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let noFavoritesTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "No Upcoming Event"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .typographyBlack
        return label
    }()
    
    private let noFavoritesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Unfortunately nothing has been found"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .typographyGray5
        return label
    }()
    
    private let exploreButton: CustomButton = {
        let button = CustomButton(
            title: "EXPLORE EVENTS",
            hasBackground: true,
            fontSize: .big,
            hasImage: true)
        
        button.backgroundColor = .primaryBlue
        button.layer.shadowColor = UIColor.shadowDark.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 10)
        button.layer.shadowRadius = 10
        button.layer.masksToBounds = false
        
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(EventCell.self, forCellWithReuseIdentifier: EventCell.description())
        view.backgroundColor = .clear
        return view
    }()
    
    weak var delegate: EventsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupUI()
        setupConstrainst()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegates(_ vc: EventsViewDelegate) {
        collectionView.delegate = vc
        collectionView.dataSource = vc
        eventsSwitch.delegate = vc
        delegate = vc
    }
    
    func indicate(_ state: Bool) {
        state ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func hideNoData(_ state: Bool) {
        noFavoritesView.isHidden = state
    }
    
    func eventsType() -> EventsType {
        eventsSwitch.isLeft ? .upcoming : .past
    }
    
    @objc func didTappedExploreButton() {
        delegate?.didTappedExploreButton()
    }
}

private extension EventsView {
    func setupUI() {
        backgroundColor = .systemBackground
        
        [
            noFavoritesImage,
            noFavoritesTitle,
            noFavoritesLabel
        ].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            noFavoritesView.addSubview(subView)
        }
        
        [
            activityIndicator,
            noFavoritesView,
            collectionView,
            titleLabel,
            eventsSwitch,
            exploreButton
        ].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subView)
        }
    }
    
    func setupConstrainst() {
        //MARK: - No data constraint
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            noFavoritesView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noFavoritesView.centerYAnchor.constraint(equalTo: centerYAnchor),
            noFavoritesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            noFavoritesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            noFavoritesView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 316.0/813.0),
            
            noFavoritesLabel.bottomAnchor.constraint(equalTo: noFavoritesView.bottomAnchor),
            noFavoritesLabel.leadingAnchor.constraint(equalTo: noFavoritesView.leadingAnchor),
            noFavoritesLabel.trailingAnchor.constraint(equalTo: noFavoritesView.trailingAnchor),
            noFavoritesLabel.heightAnchor.constraint(equalToConstant: 50),
            
            noFavoritesTitle.bottomAnchor.constraint(equalTo: noFavoritesLabel.topAnchor, constant: -8),
            noFavoritesTitle.leadingAnchor.constraint(equalTo: noFavoritesView.leadingAnchor),
            noFavoritesTitle.trailingAnchor.constraint(equalTo: noFavoritesView.trailingAnchor),
            noFavoritesTitle.heightAnchor.constraint(equalToConstant: 29),
            
            noFavoritesImage.bottomAnchor.constraint(equalTo: noFavoritesTitle.topAnchor, constant: -27),
            noFavoritesImage.centerXAnchor.constraint(equalTo: noFavoritesView.centerXAnchor),
            noFavoritesImage.topAnchor.constraint(equalTo: noFavoritesView.topAnchor),
            noFavoritesImage.widthAnchor.constraint(equalTo: noFavoritesImage.heightAnchor)
        ])
        
        //MARK: - Other constraint
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            eventsSwitch.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 22),
            eventsSwitch.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            eventsSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            eventsSwitch.heightAnchor.constraint(equalToConstant: 45),
            
            exploreButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            exploreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            exploreButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 271.0/375.0),
            exploreButton.heightAnchor.constraint(equalToConstant: 58),
            
            collectionView.topAnchor.constraint(equalTo: eventsSwitch.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: exploreButton.topAnchor, constant: -8)
        ])
    }
    
    func setupTargets() {
        exploreButton.addTarget(self, action: #selector(didTappedExploreButton), for: .touchUpInside)
    }
}
