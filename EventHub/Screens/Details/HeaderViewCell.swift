//
//  HeaderViewCell.swift
//  EventHub
//
//  Created by Олег Дербин on 24.11.2024.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    static let identifier = "HeaderViewCell"
    
    //    MARK: - UI Elements
    
    private let eventsName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "International Band Music Concert"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .white
        $0.backgroundColor = .red
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return $0
    }(UILabel())
    
    //    MARK: - Initializations
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    
    private func setupUI() {
        contentView.addSubview(eventsName)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventsName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventsName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventsName.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventsName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
