//
//  ListData.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import Foundation

struct ListData {
    static var shared = ListData()
    var eventList: [Event] = []
    var nearbyList: [Event] = []
    
     var event: ListSection {
        return .event( eventList )
    }
    
     var nearby: ListSection {
        return .nearby( nearbyList )
    }
    
    var pageData: [ListSection] {
        [event, nearby]
    }
}
