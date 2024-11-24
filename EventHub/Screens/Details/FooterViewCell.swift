//
//  FooterViewCell.swift
//  EventHub
//
//  Created by Олег Дербин on 24.11.2024.
//

import UIKit

class FooterViewCell: UITableViewCell {
    static let identifier = "FooterInfoTableView"
    
//    MARK: - UI Elements
    
    private let titleEvent: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "About Event"
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let descriptionEvent: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.text = "fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd fgfdgdf fdgdfgfd dfgdfgd dfgdfgdfg dfgdfgd dfgdfgd fdgdfgd"
        $0.textAlignment = .left
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
    
//    MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubviews(titleEvent, descriptionEvent)
        setupConstraints()
    }
    
//    MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleEvent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleEvent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleEvent.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            
            descriptionEvent.topAnchor.constraint(equalTo: titleEvent.bottomAnchor, constant: 20),
            descriptionEvent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionEvent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionEvent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
