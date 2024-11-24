//
//  SearchViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    private let searchView = SearchView()
    
    private var inputEventList: [Event]
    private var filteredEventList: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        searchView.setupDelegates(self)
        if !inputEventList.isEmpty { searchView.hideNoData(true) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        eventList = StorageManager.shared.loadFavorite()
    }
}

//MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func didTappedFilterButton() {
        print(#function)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredEventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCell.description(),
            for: indexPath
        ) as? EventCell else { return UICollectionViewCell() }
        
        let event = filteredEventList[indexPath.item]
        let favorite = StorageManager.shared.loadFavorite().contains { $0.id == event.id }
        
        cell.configure(
            imageURL: URL(string: event.images?.first?.imageUrl ?? ""),
            isFavorite: favorite,
            date: event.nextDate,
            title: event.title ?? "unknown",
            address: event.place?.address ?? event.place?.title ?? "unknown"
        )
        cell.makeFavorite(true)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 106)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\nбыла нажата ячейка:", indexPath, "\n")
        #warning("TO DO: вставить переход на детеил")
    }
}

//MARK: - EventCellDelegate
extension SearchViewController: EventCellDelegate {
    func didTapButton(in cell: EventCell) {
        
    }
}

