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
        eventsView.setupDelegates(self)
        eventsView.hideNoData(true)
        eventsView.indicate(true)
        
        fetchEvents(.upcoming)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func fetchEvents(_ type: EventsType) {
        let startDate: Int
        let endDate: Int
        let sevenDays = 60 * 60 * 24 * 7
        switch type {
        case .upcoming:
            startDate = Int(Date().timeIntervalSince1970)
            endDate = Int(Date().timeIntervalSince1970) + sevenDays
        case .past:
            startDate = Int(Date().timeIntervalSince1970) - sevenDays
            endDate = Int(Date().timeIntervalSince1970)
        }
        
        DataManager.shared.getEvents(
            startTime: startDate,
            endTime: endDate,
            pageSize: 10
        ) { events in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                eventList = events
                eventsView.indicate(false)
                eventsView.collectionView.reloadData()
                eventsView.hideNoData(!events.isEmpty)
            }
        }
    }
}

//MARK: - EventsViewDelegate
extension EventsViewController: EventsViewDelegate {
    //MARK: - Custom Switch
    func switchDidToggle() {
        eventList = []
        eventsView.collectionView.reloadData()
        eventsView.indicate(true)
        fetchEvents(eventsView.eventsType())
    }
    
    //MARK: - Explore Button
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
            date: FormatterService.shared.dateToString(event.eventDate, "E, YYYY MMM d • h:mm a").end,
            title: event.title ?? "unknown",
            address: event.place?.address ?? event.place?.title ?? "unknown"
        )
        
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
