//
//  EventCollectionViewCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleCell: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationCell: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor.green.cgColor
                print("tap on cell \(titleCell.text!)")
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       backgroundColor = .red
        setupUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        [
            imageViewCell,
            titleCell,
            locationCell
        ].forEach {contentView.addSubview($0)}
    }
    
    func configureCell(imageName: String, title: String, location: String) {
        imageViewCell.image = UIImage(named: imageName)
        imageViewCell.layer.cornerRadius = 10
        titleCell.text = title
        locationCell.text = location
    }
}

extension EventCollectionViewCell {
    func setConstraint() {
        NSLayoutConstraint.activate([
            imageViewCell.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            imageViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            imageViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
            imageViewCell.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleCell.topAnchor.constraint(equalTo: imageViewCell.bottomAnchor, constant: 5),
            titleCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            locationCell.topAnchor.constraint(equalTo: titleCell.bottomAnchor, constant: 10),
            locationCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}
  
