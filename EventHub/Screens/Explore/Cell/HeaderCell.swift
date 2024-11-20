//
//  HeaderCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.TypographyGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
        addSubview(seeAllButton)
        setConstraints()
        
        seeAllButton.addTarget(self, action: #selector(tapedSeeAll), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func tapedSeeAll() {
        print("tap see all \(headerLabel.text!)")
    }
    
    // MARK: - Methods
    
    func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            seeAllButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 20),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
