//
//  SearchView.swift
//  EventHub
//
//  Created by nikita on 24.11.24.
//

import UIKit

protocol SearchViewProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    func didTappedFilterButton()
    func didTappedBackButton()
}

final class SearchView: UIView {
    weak var delegate: SearchViewProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    private let backButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "arrow.backward")
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .label
        let button = UIButton(configuration: config)
        return button
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.searchPurple
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 24)
        field.tintColor = .primaryBlue
        field.textColor = .primaryBlue
        field.placeholder = " Search..."
        return field
    }()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primaryBlue
        button.setImage(
            UIImage(systemName: "line.3.horizontal.decrease.circle.fill"),
            for: .normal
        )
        button.setTitle(" Filters", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.tintColor = .white
        button.layer.cornerRadius = 16
        return button
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
        layout.minimumLineSpacing = 12
        
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
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegates(_ vc: SearchViewProtocol) {
        collectionView.delegate = vc
        collectionView.dataSource = vc
        searchField.delegate = vc
        delegate = vc
    }
    
    func hideNoData(_ state: Bool) {
        noFavoritesLabel.isHidden = state
    }
    
    @objc func didTappedBackButton() {
        delegate?.didTappedBackButton()
    }
    
    @objc func didTappedFilterButton() {
        delegate?.didTappedFilterButton()
    }
}

//MARK: - Setup UI
private extension SearchView {
    func setupUI() {
        backgroundColor = .systemBackground
        [
            titleLabel,
            backButton,
            searchImageView,
            searchField,
            filterButton,
            noFavoritesLabel,
            collectionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func setupConstrainst() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            searchImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            searchImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchImageView.heightAnchor.constraint(equalToConstant: 24),
            searchImageView.widthAnchor.constraint(equalToConstant: 24),
            
            filterButton.centerYAnchor.constraint(equalTo: searchImageView.centerYAnchor),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            filterButton.heightAnchor.constraint(equalToConstant: 32),
            filterButton.widthAnchor.constraint(equalToConstant: 75),
            
            searchField.centerYAnchor.constraint(equalTo: searchImageView.centerYAnchor),
            searchField.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 10),
            searchField.trailingAnchor.constraint(equalTo: filterButton.leadingAnchor, constant: 10),
            searchField.heightAnchor.constraint(equalToConstant: 32),
            
            noFavoritesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noFavoritesLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: filterButton.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupTargets() {
        filterhButton.addTarget(self, action: #selector(didTappedFilterButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTappedBackButton), for: .touchUpInside)
    }
}
