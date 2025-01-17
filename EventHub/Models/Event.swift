//
//  Event.swift
//  EventHub
//
//  Created by nikita on 19.11.24.
//

import Foundation

struct ApiResponseEvent: Decodable {
    let results: [Event]
}

struct Event: Codable {
    let id: Int?
    let title: String?
    let images: [EventImage]?
    let eventDate: [EventDate]?
    let place: Place?
    let goingCount: Int?
    let price: String?
    let participants: [Participants]?
    let text: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "short_title"
        case images = "images"
        case eventDate = "dates"
        case place = "place"
        case goingCount = "favorites_count"
        case price = "price"
        case participants = "participants"
        case text = "body_text"
        case url = "site_url"
    }
    
    var coast: Int {
        guard let price else { return 0 }
        return price
            .split(separator: " ")
            .filter { Int($0) != nil}
            .map{ Int($0) ?? 0}
            .min() ?? 0
    }
    
    var lastDate: Int {
        eventDate?.sorted(by: { lhs, rhs in
            lhs.start ?? 0 < rhs.start ?? 0
        }).last?.end ?? 0
    }
}

struct EventImage: Codable {
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
    }
}

struct EventDate: Codable {
    let start: Int?
    let end: Int?
}

struct Place: Codable {
    let title: String?
    let address: String?
    let coords: Coords?
}

struct Coords: Codable {
    let lat: Double?
    let lon: Double?
}

struct Participants: Codable {
    let role: Role?
    let agent: Agent?
}

struct Role: Codable {
    let name: String?
}

struct Agent: Codable {
    let title: String?
    let image: [EventImage]?
}

struct Category: Codable {
    let slug: String?
    let name: String?
}

struct Location: Codable {
    let slug: String?
    let name: String?
    let timezone: String?
    let coords: Coords?
    let language: String?
    let currency: String?
}
