//
//  ScreenViewController.swift
//  EventHub
//
//  Created by Олег Дербин on 18.11.2024.
//

import UIKit

class ScreenViewController: UIViewController {
    
    private let screenImage: UIImageView = {
        $0.image = UIImage(named: "Onbording")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
}
