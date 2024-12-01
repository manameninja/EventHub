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
        $0.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    let descriptionEvent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 16
        let text = "dsfdsf sdfsd sdfdsfsd dsfsdf sdfsdf sdfsdfsd fsfds fdsf sdfsd sdfdsfsd dsfsdf sdfsdf sdfsdfsd fsfds fdsf sdfsd sdfdsfsd dsfsdf sdfsdf sdfsdfsd fsfds fdsf sdfsd sdfdsfsd dsfsdf sdfsdf sdfsdfsd fsfds "
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.systemFont(ofSize: 16, weight: .light)
            ]
        )
        
        label.attributedText = attributedString
        return label
    }()
    
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
    
    func setCell(model: Event?) {
        if let model {
            descriptionEvent.text = model.text
        }
    }
    
    //    MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleEvent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleEvent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleEvent.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            
            descriptionEvent.topAnchor.constraint(equalTo: titleEvent.bottomAnchor, constant: 20),
            descriptionEvent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descriptionEvent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            descriptionEvent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
