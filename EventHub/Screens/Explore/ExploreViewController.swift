//
//  ExploreViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - Properties
    let exploreView = ExploreView()
    private let sections = ListData.shared.pageData
    private var category: [CategoryItem] = []
    
    // MARK: - LifeCycle
    override func loadView() {
        view = exploreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreView.setDelegates(self)
        DataManager.shared.getCategories { categories in
            DispatchQueue.main.async {
                self.category = categories.map {CategoryItem(from: $0)}
                self.exploreView.categoryCollectionView.reloadData()
            }
        }
    }

}

// MARK: - CreateLayoutDelegate
extension ExploreViewController: CreateLayoutDelegate {
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout {[weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
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

// MARK: - CollectionView Delegate
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == exploreView.categoryCollectionView {
            return 1
        } else if collectionView == exploreView.collectionView {
            return sections.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exploreView.categoryCollectionView {
            return category.count
        } else if collectionView == exploreView.collectionView {
            return sections[section].count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exploreView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell() }
            
            cell.configureCell(category: category[indexPath.row].name)
            
            return cell
        } else if collectionView == exploreView.collectionView {
            switch sections[indexPath.section] {
            case .event(let event):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configureCell(imageName: event[indexPath.row].image, title: event[indexPath.row].title, location: event[indexPath.row].place)
                
                return cell
            case .nearby(let event):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyCell", for: indexPath) as? NearbyCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                cell.configureCell(imageName: event[indexPath.row].image, title: event[indexPath.row].title)
                
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            header.configureHeader(categoryName: sections[indexPath.section].title)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = category[indexPath.row].name
        cell.backgroundColor = .blue
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
