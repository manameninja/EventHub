//
//  TestView.swift
//  EventHub
//
//  Created by nikita on 19.11.24.
//

import UIKit

protocol TestViewProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
}

final class TestView: UIView {
    private let searchField: UISearchTextField = {
        let field = UISearchTextField()
        return field
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(TestCell.self, forCellWithReuseIdentifier: TestCell.description())
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDelegates(_ vc: TestViewProtocol) {
        collectionView.delegate = vc
        collectionView.dataSource = vc
    }
    
    func indicate(_ state: Bool) {
        state ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
}

//MARK: - Setup UI
private extension TestView {
    func setupUI() {
        backgroundColor = .systemBackground
        
        [
            searchField,
            collectionView,
            activityIndicator
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchField.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: searchField.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: searchField.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupTargets() {
        
    }
}
