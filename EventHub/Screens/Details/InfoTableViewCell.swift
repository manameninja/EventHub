//
//  InfoTableViewCell.swift
//  EventHub
//
//  Created by Олег Дербин on 22.11.2024.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    static let identifier = "InfoTableViewCell"
    
    //    MARK: - UI Elements
    
    let iconView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
        private let infoTitle: UILabel = {
            $0.text = "14 December, 2021"
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 16)
            return $0
        }(UILabel())
    
        private let infoSubTitle: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "Tuesday, 4:00PM - 9:00PM"
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .gray
            return $0
        }(UILabel())
    
    //    MARK: - Initializations
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - SetupUI
    private func setupUI() {
        contentView.addSubviews(iconView, infoTitle, infoSubTitle)
        setupConstraints()
    }
    
    //    MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconView.heightAnchor.constraint(equalToConstant: 48),
            iconView.widthAnchor.constraint(equalToConstant: 48),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            infoTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 15),
            infoTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            infoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            infoSubTitle.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 5),
            infoSubTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            infoSubTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
            
        ])
    }
}
