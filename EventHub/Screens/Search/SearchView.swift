//
//  SearchView.swift
//  EventHub
//
//  Created by nikita on 24.11.24.
//

import UIKit

protocol SearchViewProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchTextFieldDelegate {
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
    
    private let searchField: UISearchTextField = {
        let field = UISearchTextField()
        field.leftView?.tintColor = .primaryBlue
        field.textColor = .primaryBlue
        field.placeholder = "Search..."
        
        let rightImageView = UIImageView(image: UIImage(systemName: "xmark.circle.fill"))
        rightImageView.tintColor = .primaryBlue
        field.rightView = rightImageView
        field.rightViewMode = .whileEditing
        
        field.layer.borderColor = UIColor.red.cgColor
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 1.0
        
        let apperance = UISearchTextField.appearance().backgroundColor = .clear
        
        field.
        
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
        backgroundColor = .backgroundLightGray
        [
            titleLabel,
            backButton,
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
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            filterhButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
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
