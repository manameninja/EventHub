//
//  TestViewController.swift
//  EventHub
//
//  Created by nikita on 19.11.24.
//

import UIKit

final class TestViewController: UIViewController {
    private let testView = TestView()
    
    private var eventList: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = testView
        testView.setupDelegates(self)
        testView.indicate(true)
        
        DataManager.shared.getCategories { categories in
            //что-то делаем с массивом Категорий
        }
        
        DataManager.shared.getLocations { locations in
            //что-то делаем с массивом Локаций
        }
        
        DataManager.shared.getEvents(category: "concert") { events in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                eventList = events
                testView.indicate(false)
                testView.collectionView.reloadData()
            }
        }
    }
}

extension TestViewController: TestViewProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        eventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TestCell.description(),
            for: indexPath
        ) as? TestCell else { return UICollectionViewCell() }
        
        cell.configure(with: eventList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 500)
    }
}
