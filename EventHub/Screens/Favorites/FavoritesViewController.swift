//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private let favoritesView = FavoritesView()
    
    private var eventList: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = favoritesView
        
        favoritesView.setupDelegates(self)
        
        DataManager.shared.getEvents() { events in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                eventList = events
                favoritesView.collectionView.reloadData()
            }
        }
    }
}

//MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        eventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCell.description(),
            for: indexPath
        ) as? EventCell else { return UICollectionViewCell() }
        
        cell.configure(with: eventList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 24 * 2, height: 106)
    }
}
