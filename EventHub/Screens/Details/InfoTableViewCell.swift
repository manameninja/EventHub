//
//  TableViewCell.swift
//  EventHub
//
//  Created by Олег Дербин on 22.11.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
//    MARK: - UI Elements
    
    private let iconView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .yellow
        return $0
    }(UIView())
    
    private let infoTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let infoSubTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(iconView, infoTitle, infoSubTitle)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 50),
            iconView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
