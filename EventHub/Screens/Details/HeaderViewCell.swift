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
    
     let eventsName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "International Band Music Concert"
        $0.numberOfLines = 0
        $0.textAlignment = .left
         $0.textColor = UIColor.label
        $0.lineBreakMode = .byWordWrapping
         $0.font = UIFont(name: "AvenirNext-Regular", size: 35)
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
    
    //MARK: - SetupUI
    
    private func setupUI() {
        contentView.addSubview(eventsName)
        setupConstraints()
    }
    
    func setCell(model: Event?) {
        if let model {
            eventsName.text = model.title
        }
    }
    
//    MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            eventsName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            eventsName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            eventsName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 45),
            eventsName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
}
