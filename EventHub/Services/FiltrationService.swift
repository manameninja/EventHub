//
//  FiltrationService.swift
//  EventHub
//
//  Created by nikita on 26.11.24.
//

import Foundation

final class FiltrationService {
    static let shared = FiltrationService()
    
    private init() {}
    
    func filter(_ events: [Event], with key: String) -> [Event] {
        let lowercasedKey = key.lowercased()
        
        return events.filter { event in
            if let title = event.title?.lowercased(), title.contains(lowercasedKey) {
                return true
            }
            
            if let place = event.place {
                if let placeTitle = place.title?.lowercased(), placeTitle.contains(lowercasedKey) {
                    return true
                }
                if let address = place.address?.lowercased(), address.contains(lowercasedKey) {
                    return true
                }
            }
            
            if let text = event.text?.lowercased(), text.contains(lowercasedKey) {
                return true
            }
            
            if let participants = event.participants {
                for participant in participants {
                    if let roleName = participant.role?.name?.lowercased(), roleName.contains(lowercasedKey) {
                        return true
                    }
                    if let agentTitle = participant.agent?.title?.lowercased(), agentTitle.contains(lowercasedKey) {
                        return true
                    }
                }
            }
            
            return false
        }
    }
}
