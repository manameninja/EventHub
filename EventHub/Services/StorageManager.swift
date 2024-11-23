//
//  StorageManager.swift
//  EventHub
//
//  Created by nikita on 23.11.24.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private let storageKey = "favoriteEvents"
    
    private init() {}
    
    func loadFavorite() -> [Event] {
        if let favoriteEvents = UserDefaults.standard.data(forKey: storageKey),
           let events = try? JSONDecoder().decode([Event].self, from: favoriteEvents) {
            return events
        }
        return []
    }
    
    func saveFavorites(_ events: [Event]) {
        if let encodedEvents = try? JSONEncoder().encode(events) {
            UserDefaults.standard.set(encodedEvents, forKey: storageKey)
        }
    }
    
    func addFavorite(_ event: Event) {
        let events = loadFavorite() + [event]
        saveFavorites(events)
    }
    
    func deleteFavorite(_ event: Event) {
        let events = loadFavorite().filter { $0.id != event.id }
        saveFavorites(events)
    }
}
