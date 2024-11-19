//
//  ListSection.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import Foundation

enum ListSection {
    case event([ListItem])
    case nearby([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .event(let items),
                .nearby(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
//    название header sections
    var title: String {
        switch self {
        case .event(_):
            "Upcoming Event"
        case .nearby(_):
            "Nearby You"
        }
    }
}

