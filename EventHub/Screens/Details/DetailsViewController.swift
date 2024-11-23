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
        setupConstraints()
    }
    
    private func setupTableView() {
        customView.infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        customView.infoTableView.register(HeaderInfoTableView.self, forHeaderFooterViewReuseIdentifier: HeaderInfoTableView.identifier)
        customView.infoTableView.delegate = self
        customView.infoTableView.dataSource = self
        customView.infoTableView.separatorStyle = .none
        customView.infoTableView.isScrollEnabled = false
    }
    
    //    MARK: - Setup Constraints
    
    private func setupConstraints() {
        
    }
    
    
    
}

//MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    
//    MARK: - Header Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderInfoTableView.identifier) as? HeaderInfoTableView else { return nil }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
}

//MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath)
        return cell
    }
    
}

#Preview {
    DetailsViewController()
}
