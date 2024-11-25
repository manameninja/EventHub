//
//  DetailsViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    //    MARK: - UI Elements
    private let customView = DetailsView()
    
//    MARK: - Properties
    private var model: Event?
    
//    MARK: - Initializations
//    init(model: Event) {
//        self.model = model
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //    MARK: - SetupUI
    private func setupUI() {
        view = customView
        setupTableView()
        customView.shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        customView.infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        customView.infoTableView.register(HeaderViewCell.self, forCellReuseIdentifier: HeaderViewCell.identifier)
        customView.infoTableView.register(FooterViewCell.self, forCellReuseIdentifier: FooterViewCell.identifier)
        customView.infoTableView.delegate = self
        customView.infoTableView.dataSource = self
        customView.infoTableView.separatorStyle = .none
        customView.infoTableView.showsVerticalScrollIndicator = false
        customView.infoTableView.allowsSelection = false
    }
    
    private func setupDataToNavBar() {
        customView.customNavBar.kf.setImage(
            with: URL(string: model?.images?.first?.imageUrl ?? ""),
            placeholder: UIImage(named: "CustomNav")
        )
    }
    
//    private func setupDataToCell(to cell: UITableViewCell, from data: Event, _ row: Int? = nil) {
//        if let headerCell = cell as? HeaderViewCell {
//            headerCell.eventsName.text = model?.title
//        } else if let infoCell = cell as? InfoTableViewCell {
//            switch row {
//            case 1: infoCell.infoSubTitle.text = model.eventDate
//            }
//        }
//    }
    
}

//MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
}

//MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderViewCell.identifier, for: indexPath)
            return headerCell
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let footerCell = tableView.dequeueReusableCell(withIdentifier: FooterViewCell.identifier, for: indexPath)
            return footerCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
            if indexPath.row == 1 {
                cell.iconView.image = UIImage(resource: .date)
            } else if indexPath.row == 2 {
                cell.iconView.image = UIImage(resource: .location)
            } else {
                cell.iconView.image = UIImage(resource: .owner)
            }
            return cell
        }
    }
    
}

//MARK: - Actions

extension DetailsViewController {
    
    @objc func shareTapped() {
        let activityVC = UIActivityViewController(activityItems: [model?.url ?? ""], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
}

//#Preview {
//    DetailsViewController()
//}
