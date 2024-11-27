//
//  EventsViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

final class EventsViewController: UIViewController {
    private let eventsView = EventsView()
    
    private var eventList: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = eventsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}

//MARK: - EventsViewDelegate
extension EventsViewController: EventsViewDelegate {
    //MARK: - Actions
    func didTappedExploreButton() {
        print(#function)
    }
    
    //MARK: - Collection View Delegate
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
            date: event.nextDate,
            title: event.title ?? "unknown",
            address: event.place?.address ?? event.place?.title ?? "unknown"
        )
        cell.makeFavorite(true)
        
        cell.delegate = self
        
        return cell
    }
}

extension EventsViewController: EventCellDelegate {
    func didTapButton(in cell: EventCell) {
        if let indexPath = eventsView.collectionView.indexPath(for: cell) {
            if StorageManager.shared.loadFavorite().contains(where: {
                $0.id == eventList[indexPath.item].id
            }) {
                StorageManager.shared.deleteFavorite(eventList[indexPath.item])
                cell.makeFavorite(false)
            } else {
                StorageManager.shared.addFavorite(eventList[indexPath.item])
                cell.makeFavorite(true)
            }
        }
    }
}
