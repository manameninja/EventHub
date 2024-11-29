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
    let goingCount: Int
    let startDate: Int
    
    init(from event: Event) {
        self.title = event.title ?? ""
        self.image = event.images?[0].imageUrl ?? ""
        self.place = event.place?.address ?? ""
        self.goingCount = event.goingCount ?? 0
        self.startDate = event.eventDate?[0].start ?? 0
    }
}

struct CategoryItem {
    let slug: String
    let name: String
    
    init(from category: Category) {
        self.name = category.name ?? ""
        self.slug = category.slug ?? ""
    }
}

typealias CategoryItems = [CategoryItem]

