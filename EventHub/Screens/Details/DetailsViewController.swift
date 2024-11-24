//
//  DetailsViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //    MARK: - UI Elements
    private let customView = DetailsView()
    
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
        let activityVC = UIActivityViewController(activityItems: [], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true)
    }
}

#Preview {
    DetailsViewController()
}
