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
    private var filteredEventList: [Event]
    
    init(eventList: [Event]) {
        inputEventList = eventList
        filteredEventList = eventList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        searchView.setupDelegates(self)
        if !inputEventList.isEmpty { searchView.hideNoData(true) }
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    //MARK: - buttons delegates
    func didTappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTappedFilterButton() {
        print(#function)
    }
    
    //MARK: - Search text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    //MARK: - Collection View delegate
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
        CGSize(width: collectionView.frame.width - 24 * 2, height: 106)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\nбыла нажата ячейка:", indexPath, "\n")
#warning("TO DO: вставить переход на детеил")
    }
}

//MARK: - EventCellDelegate
extension SearchViewController: EventCellDelegate {
    func didTapButton(in cell: EventCell) {
        if let indexPath = searchView.collectionView.indexPath(for: cell) {
            if StorageManager.shared.loadFavorite().contains(where: {
                $0.id == filteredEventList[indexPath.item].id
            }) {
                StorageManager.shared.deleteFavorite(filteredEventList[indexPath.item])
                cell.makeFavorite(false)
            } else {
                StorageManager.shared.addFavorite(filteredEventList[indexPath.item])
                cell.makeFavorite(true)
            }
        }
    }
}

