//
//  HeaderCell.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import UIKit

protocol HeaderCellDelegate: AnyObject {
    func presentSearchVC(for sectionType: ListSection)
}

class HeaderCell: UICollectionReusableView {
    // MARK: - Properties
    static let identifier = HeaderCell.description()
    weak var delegate: HeaderCellDelegate?
    private var sectionType: ListSection?
    
    private let headerLabel = UILabel(fontSize: 24, color: .black, weight: .bold)
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.typographyGray, for: .normal)
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
        guard let sectionType = sectionType else { return }
        delegate?.presentSearchVC(for: sectionType)
        print("tap see all \(headerLabel.text!)")
    }
    
    // MARK: - Methods
    func configureHeader(categoryName: String, sectionType: ListSection) {
        headerLabel.text = categoryName
        self.sectionType = sectionType
    }
    
    // MARK: - Constraints
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
