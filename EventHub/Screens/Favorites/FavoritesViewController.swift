//
//  FavoritesViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    private let favoritesView = FavoritesView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = favoritesView
    }
}
