//
//  ExploreViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - Properties
    private let exploreView = ExploreView()
    private var sections: [ListSection] = []
    private var category: [Category] = []
    private var filteredSections: [ListSection] = []
    private var categoryID: String = "exhibition"
    
    // MARK: - LifeCycle
    override func loadView() {
        view = exploreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreView.setDelegates(self)
        
        DataManager.shared.getCategories { categories in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                category = categories
                exploreView.setupFilterMenu(with: category)
                exploreView.categoryCollectionView.reloadData()
            }
        }
        
        DataManager.shared.getEvents(category: categoryID) { [weak self] events in
            DispatchQueue.main.async {
                guard let self = self else { return }
                ListData.shared.eventList = events
                self.sections = ListData.shared.pageData
                self.filteredSections = self.sections
                self.exploreView.collectionView.reloadData()
            }
        }
        
        DataManager.shared.getEvents(category: "cinema") { [weak self] events in
            DispatchQueue.main.async {
                guard let self = self else { return }
                ListData.shared.nearbyList = events
                self.sections = ListData.shared.pageData
                self.filteredSections = self.sections
                self.exploreView.collectionView.reloadData()
            }
        }
    }
}

// MARK: - CreateLayoutDelegate
extension ExploreViewController: CreateLayoutDelegate {
    
    func fetchData(categoryID: String) {
        DataManager.shared.getEvents(category: categoryID) { [weak self] events in
            DispatchQueue.main.async {
                guard let self = self else { return }
                ListData.shared.eventList = events
                self.sections = ListData.shared.pageData
                self.filteredSections = self.sections
                self.exploreView.collectionView.reloadData()
            }
        }
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout {[weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.filteredSections[sectionIndex]
            switch section {
            case .event(_):
                return createEventsSection()
            case .nearby(_):
                return createNearbySection()
            }
        }
    }
    
    private func createLayoutSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
        contentInsets: NSDirectionalEdgeInsets
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.contentInsets = contentInsets
        
        return section
    }
    
    private func createEventsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(1.0))
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.8),
                              heightDimension: .fractionalHeight(0.5)),
            subitems: [item]
        )
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpacing: 16,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        )
        
        return section
    }
    
    private func createNearbySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalHeight(1.0))
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.8),
                              heightDimension: .fractionalHeight(0.5)),
            subitems: [item]
        )
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpacing: 16,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        )
        
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem { .init(
        layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40)),
        elementKind: UICollectionView.elementKindSectionHeader,
        alignment: .top
    )
    }
}

// MARK: - CollectionViewDelegate, UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == exploreView.categoryCollectionView {
            return 1
        } else if collectionView == exploreView.collectionView {
            return filteredSections.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exploreView.categoryCollectionView {
            return category.count
        } else if collectionView == exploreView.collectionView {
            return filteredSections[section].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exploreView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell() }
            cell.contentView.backgroundColor = indexPath.alternatingColor()
            cell.configureCell(
                category: category[indexPath.row].name ?? "",
                index: indexPath.row
            )
            
            return cell
        } else if collectionView == exploreView.collectionView {
            switch filteredSections[indexPath.section] {
            case .event(let event):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as? EventCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configureCell(
                    imageName: event[indexPath.row].images?.first?.imageUrl ?? "",
                    title: event[indexPath.row].title ?? "unknown",
                    location: event[indexPath.row].place?.address ?? "",
                    goingCount: event[indexPath.row].goingCount ?? 0,
                    date: event[indexPath.row].eventDate?[0].start ?? 0
                )
                
                return cell
            case .nearby(let event):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as? EventCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configureCell(
                    imageName: event[indexPath.row].images?.first?.imageUrl ?? "",
                    title: event[indexPath.row].title ?? "unknown",
                    location: event[indexPath.row].place?.address ?? "",
                    goingCount: event[indexPath.row].goingCount ?? 0,
                    date: event[indexPath.row].eventDate?[0].start ?? 0
                )
                
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == exploreView.categoryCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) else { return }
            fetchData(categoryID: category[indexPath.row].slug ?? "")
            print("\(category[indexPath.row].slug!)")
            
//            SearchViewController(eventList: ListData.shared.eventList)
            
            UIView
                .animate(
                    withDuration: 0.1,
                    animations: { cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    }) {
                        _ in UIView
                            .animate(
                                withDuration: 0.1,
                                animations: { cell.transform = CGAffineTransform.identity
                                })
                    }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.identifier, for: indexPath) as! HeaderCell
            header.configureHeader(categoryName: filteredSections[indexPath.section].title)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == exploreView.categoryCollectionView {
            
            return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        return UIEdgeInsets()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = category[indexPath.row].name
        content.textProperties.color = .white
        content.textProperties.font = .systemFont(ofSize: 12)
        cell.contentConfiguration = content
        cell.backgroundColor = .primaryBlue
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        exploreView.currentLocationButton.setTitle(category[indexPath.row].name, for: .normal)
        exploreView.hideTableView()
    }
}

// MARK: - UITextFieldDelegate
extension ExploreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        if newText.isEmpty {
            filteredSections = sections
        } else {
            let filteredEventList = ListData.shared.eventList.filter {
                $0.title?.lowercased().contains(newText.lowercased()) == true
            }
            let filteredNearbyList = ListData.shared.nearbyList.filter {
                $0.title?.lowercased().contains(newText.lowercased()) == true
            }
            
            filteredSections = [
                .event(filteredEventList),
                .nearby(filteredNearbyList)
            ]
        }
        exploreView.collectionView.reloadData()
        
        return true
    }
}

// MARK: - Extension IndexPath
extension IndexPath {
    func alternatingColor() -> UIColor {
        switch self.item % 3 {
        case 0:
            return .accentGreen
        case 1:
            return .accentOrange
        case 2:
            return .accentDarkCyan
        default:
            return .accentPurple
        }
    }
}
