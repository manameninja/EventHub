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
    
    //MARK: - Favorites
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
    
    //MARK: - User
    func loadUser() -> UserData? {
        if let user = UserDefaults.standard.data(forKey: "user"),
           let userData = try? JSONDecoder().decode(UserData.self, from: user) {
            return userData
        }
        return nil
    }
    
    func saveUser(_ userData: UserData) {
        if let user = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(user, forKey: "user")
        }
    }
}
