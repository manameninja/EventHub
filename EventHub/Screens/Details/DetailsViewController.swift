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
    lazy var dimmingView: UIView = {
        $0.backgroundColor = .black
        $0.alpha = 0.5
        $0.frame = view.bounds
        $0.tag = 777
        return $0
    }(UIView())
    
//    MARK: - Properties
    private var model: Event
    private var isFavorite = false
    
//    MARK: - Initializations
    init(model: Event) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //    MARK: - SetupUI
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view = customView
        setupTableView()
        customView.shareButton.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        customView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        customView.bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        customView.setNavBar(model: model)
        updateBookmarkButton()
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
        if model.participants == nil {
            return 4
        } else {
            return 4 + model.participants!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: HeaderViewCell.identifier, for: indexPath) as? HeaderViewCell else { return UITableViewCell() }
            headerCell.setCell(model: model)
            return headerCell
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            guard let footerCell = tableView.dequeueReusableCell(withIdentifier: FooterViewCell.identifier, for: indexPath) as? FooterViewCell else { return UITableViewCell() }
            footerCell.setCell(model: model)
            return footerCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else { return UITableViewCell() }
            if indexPath.row == 1 {
                cell.setInfoCell(model: model, indexPath.row)
            } else if indexPath.row == 2 {
                cell.setInfoCell(model: model, indexPath.row)
            } else {
                cell.setInfoCell(model: model, indexPath.row)
            }
            return cell
        }
    }
    
}

//MARK: - Actions

extension DetailsViewController {
    
    @objc func shareTapped() {
        
        let customAC = CustomActivityController()
        customAC.modalPresentationStyle = .pageSheet
        present(customAC, animated: true)
        view.addSubview(dimmingView)
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func bookmarkTapped() {
        if isFavorite {
            StorageManager.shared.deleteFavorite(model)
            isFavorite.toggle()
        } else {
            StorageManager.shared.addFavorite(model)
            isFavorite = true
        }
        updateBookmarkButton()
    }
}

//MARK: - Methods

extension DetailsViewController {
    private func updateBookmarkButton() {
        if StorageManager.shared.loadFavorite().contains(where: { $0.url == model.url }) {
            customView.bookmarkButton.setImage(UIImage(resource: .bookmarkSelect), for: .normal)
            isFavorite = true
        } else {
            customView.bookmarkButton.setImage(UIImage(resource: .bookmark), for: .normal)
        }
    }
}

//#Preview {
//    DetailsViewController()
//}
