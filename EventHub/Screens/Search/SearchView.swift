//
//  SearchView.swift
//  EventHub
//
//  Created by nikita on 24.11.24.
//

import UIKit

protocol SearchViewProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func didTappedFilterButton()
}

final class SearchView: UIView {
    weak var delegate: SearchViewProtocol?
    
    private let searchField: UISearchTextField = {
        let field = UISearchTextField()
        return field
    }()
    
    private let filterhButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "magnifyingglass")
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .label
        let button = UIButton(configuration: config)
        return button
    }()
    
    private let noFavoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "NO RESULTS"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
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
        
        backgroundColor = .backgroundLightGray
        
        setupUI()
        setupConstrainst()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegates(_ vc: SearchViewProtocol) {
        collectionView.delegate = vc
        collectionView.dataSource = vc
        delegate = vc
    }
    
    func hideNoData(_ state: Bool) {
        noFavoritesLabel.isHidden = state
    }
    
    @objc func buttonTapped() {
        delegate?.didTappedFilterButton()
    }
}

//MARK: - Setup UI
private extension SearchView {
    func setupUI() {
        backgroundColor = .backgroundLightGray
        [
            searchField,
            filterhButton,
            noFavoritesLabel,
            collectionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func setupConstrainst() {
        NSLayoutConstraint.activate([
            filterhButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            filterhButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            filterhButton.heightAnchor.constraint(equalToConstant: 32),
            filterhButton.widthAnchor.constraint(equalToConstant: 75),
            
            searchField.topAnchor.constraint(equalTo: filterhButton.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchField.trailingAnchor.constraint(equalTo: filterhButton.leadingAnchor, constant: -8),
            searchField.bottomAnchor.constraint(equalTo: filterhButton.bottomAnchor),
            
            noFavoritesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noFavoritesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: filterhButton.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: filterhButton.leftAnchor),
            collectionView.trailingAnchor.constraint(equalTo: filterhButton.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupTargets() {
        filterhButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}
