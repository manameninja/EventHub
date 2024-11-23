//
//  HeaderInfoTableView.swift
//  EventHub
//
//  Created by Олег Дербин on 23.11.2024.
//

import UIKit

class HeaderInfoTableView: UITableViewHeaderFooterView {
    static let identifier = "HeaderInfoTableView"
    
//    MARK: - UI Elements
    
    private let eventsName: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "International Band Music Concert"
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .white
        $0.backgroundColor = .red
        $0.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        return $0
    }(UILabel())
  
//    MARK: - Initializations
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
//            eventsName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

}
