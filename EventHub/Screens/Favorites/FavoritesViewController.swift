//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private let favoritesView = FavoritesView()
    
    private var eventList: [Event] = StorageManager.shared.loadFavorite()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoritesView
        favoritesView.setupDelegates(self)
        if !eventList.isEmpty { favoritesView.hideNoData(true) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        eventList = StorageManager.shared.loadFavorite()
        favoritesView.collectionView.reloadData()
    }
}

//MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    func didTappedSearchButton() {
        navigationController?.pushViewController(SearchViewController(eventList: eventList), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        eventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCell.description(),
            for: indexPath
        ) as? EventCell else { return UICollectionViewCell() }
        
        let event = eventList[indexPath.item]
        let favorite = StorageManager.shared.loadFavorite().contains { $0.id == event.id }
        
        cell.configure(
            imageURL: URL(string: event.images?.first?.imageUrl ?? ""),
            isFavorite: favorite,
            date: FormatterService.shared.dateToString(event.eventDate, "E, YYYY MMM d • h:mm a").end,
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
        navigationController?.pushViewController(DetailsViewController(model: eventList[indexPath.item]), animated: true)
    }
}

//MARK: - EventCellDelegate
extension FavoritesViewController: EventCellDelegate {
    func didTapButton(in cell: EventCell) {
        if let indexPath = favoritesView.collectionView.indexPath(for: cell) {
            StorageManager.shared.deleteFavorite(eventList[indexPath.item])
            eventList.remove(at: indexPath.item)
            favoritesView.collectionView.deleteItems(at: [indexPath])
        }
        if eventList.isEmpty {
            favoritesView.hideNoData(false)
        }
    }
}
