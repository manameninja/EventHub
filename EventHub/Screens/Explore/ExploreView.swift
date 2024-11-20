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
    
    private func setViews() {
        backgroundColor = .BackgroundGray
        let backgroundView = UIView()
        backgroundView.backgroundColor = backgroundColor
        self.addSubview(collectionView)
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "eventCell")
        collectionView.register(NearbyCollectionViewCell.self, forCellWithReuseIdentifier: "nearbyCell")
        collectionView.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
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
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
        ])
    }
}
