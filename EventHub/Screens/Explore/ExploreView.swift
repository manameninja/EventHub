//
//  ExploreView.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 19.11.2024.
//

import UIKit

protocol CreateLayoutDelegate: AnyObject {
    func createLayout() -> UICollectionViewCompositionalLayout
}

final class ExploreView: UIView {
    
    // MARK: - Properties
    weak var delegate: CreateLayoutDelegate?
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .PrimaryBlue
        view.layer.cornerRadius = 30
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.barTintColor = .PrimaryBlue
        searchBar.barStyle = .default
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.bordered()
        configuration.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")
        configuration.title = "Filter"
        configuration.imagePlacement = .leading
        configuration.contentInsets.leading = 5
        configuration.imagePadding = 5
        button.tintColor = .BackgroundGray
        button.backgroundColor = .blue
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .BackgroundGray
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        filterButton.layer.cornerRadius = filterButton.bounds.height / 2
    }
    
    private func setViews() {
        backgroundColor = .BackgroundGray
        let backgroundView = UIView()
        backgroundView.backgroundColor = backgroundColor
        [
            mainView,
            collectionView
        ].forEach {addSubview($0)}
        [
            searchBar,
            filterButton
        ].forEach {mainView.addSubview($0)}
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "eventCell")
        collectionView.register(NearbyCollectionViewCell.self, forCellWithReuseIdentifier: "nearbyCell")
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
//        filterButton.addTarget(self, action: <#T##Selector#>, for: .touchUpInside)
    }
    
    func setDelegates(_ value: ExploreViewController) {
        delegate = value
        collectionView.delegate = value
        collectionView.dataSource = value
        //        после делегата!!! а то будет nil
        if let layout = delegate?.createLayout() {
            collectionView.collectionViewLayout = layout
        }
    }
}

// MARK: - Extensions SetConstraints
extension ExploreView {
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.22),
            
            searchBar.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 104),
            searchBar.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 24),
            
            filterButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 10),
            filterButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -24),
            filterButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            filterButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)
        ])
    }
}
