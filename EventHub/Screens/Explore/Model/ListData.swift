//
//  ListData.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import Foundation

struct ListData {
    static var shared = ListData()
    private var eventList: [Event] = []
    private var nearbyList: [Event] = []
    
    private var event: ListSection {
        return .event( eventList.map { ListItem(from: $0) })
    }
    
    private var nearby: ListSection {
        return .nearby( nearbyList.map { ListItem(from: $0)})
    }
    
    var pageData: [ListSection] {
        [event, nearby]
    }
    
    mutating func updateEvents(with events: [Event]) {
        self.eventList = events
    }
    
    mutating func updateEvents(location events: [Event]) {
        self.nearbyList = events
    }
}
