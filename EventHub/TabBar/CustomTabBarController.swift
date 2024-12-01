//
//  CustomTabBarViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 19.11.2024.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private let customTabBar = CustomTabBar()
    private let favoritesButton = FavoritesButton()
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.selectedIndex
        if selectedIndex == 2 {
            favoritesButton.backgroundColor = .accentRed
        } else {
            favoritesButton.backgroundColor = .primaryBlue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(customTabBar, forKey: "tabBar")
        delegate = self
        
        setupTabItems()
        setupFavoritesButton()
        favoritesButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupTabItems() {
        
        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem.title = "Explore"
        exploreVC.tabBarItem.image = UIImage(named: "compasTabBar")
        
        let eventsVC = EventsViewController()
        eventsVC.tabBarItem.title = "Events"
        eventsVC.tabBarItem.image = UIImage(named: "calendarTabBar")
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem.title = ""
        
        let mapsVC = OnboardingViewController()
        mapsVC.tabBarItem.title = "Map"
        mapsVC.tabBarItem.image = UIImage(named: "mapTabBar")
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "profileTabBar")
        
        setViewControllers([exploreVC, eventsVC, favoritesVC, mapsVC, profileVC], animated: true)
    }
    
    private func setupFavoritesButton() {
        view.addSubview(favoritesButton)
        NSLayoutConstraint.activate([
            favoritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoritesButton.centerYAnchor.constraint(equalTo: customTabBar.topAnchor),
            favoritesButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.13),
            favoritesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.13)
        ])
    }
    
    @objc func buttonTapped() {
        favoritesButton.backgroundColor = .accentRed
        self.selectedIndex = 2
    }
    
}
