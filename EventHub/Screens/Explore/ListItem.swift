//
//  ListItem.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import Foundation

struct ListItem {
    let title: String
    let image: String
    let place: String
}

struct CategoryItem {
    let id: Int
    let name: String
}

typealias CategoryItems = [CategoryItem]
