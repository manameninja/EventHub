//
//  FavoritesView.swift
//  EventHub
//
//  Created by nikita on 20.11.24.
//

import UIKit

protocol FavoritesViewProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
}

final class FavoritesView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private let searchButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "magnifyingglass")
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .label
        let button = UIButton(configuration: config)
        return button
    }()
    
    private let noFavoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "NO FAVORITES"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let noFavoritesImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(
            systemName: "bookmark.slash",
            withConfiguration: UIImage.SymbolConfiguration(weight: .ultraLight)
        )
        view.tintColor = .red
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(EventCell.self, forCellWithReuseIdentifier: EventCell.description())
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupUI()
        setupConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegates(_ vc: FavoritesViewProtocol) {
        collectionView.delegate = vc
        collectionView.dataSource = vc
    }
    
    func hideNoData(_ state: Bool) {
        noFavoritesLabel.isHidden = state
        noFavoritesImage.isHidden = state
    }
}

//MARK: - Setup UI
private extension FavoritesView {
    func setupUI() {
        backgroundColor = .backgroundGray
        
        [
            titleLabel,
            searchButton,
            noFavoritesLabel,
            noFavoritesImage,
            collectionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func setupConstrainst() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            noFavoritesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noFavoritesLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            noFavoritesLabel.heightAnchor.constraint(equalToConstant: 28),
            
            noFavoritesImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            noFavoritesImage.topAnchor.constraint(equalTo: centerYAnchor, constant: 8),
            noFavoritesImage.heightAnchor.constraint(equalToConstant: 150),
            noFavoritesImage.widthAnchor.constraint(equalToConstant: 150),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
