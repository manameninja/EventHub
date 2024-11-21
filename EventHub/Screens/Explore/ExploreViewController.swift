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
    private let sections = ListData.shared.pageData
    
    // MARK: - LifeCycle
    override func loadView() {
        view = exploreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreView.setDelegates(self)
    }
}

// MARK: - Extensions CreateLayoutDelegate
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

// MARK: - Extensions CollectionView Delegate
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .event(let event):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as? EventCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configureCell(imageName: event[indexPath.row].image, title: event[indexPath.row].title, location: event[indexPath.row].place)
            
            return cell
        case .nearby(let event):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearbyCell", for: indexPath) as? NearbyCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configureCell(imageName: event[indexPath.row].image, title: event[indexPath.row].title)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as! HeaderCell
            header.configureHeader(categoryName: sections[indexPath.section].title)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
