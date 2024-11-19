//
//  Event.swift
//  EventHub
//
//  Created by nikita on 19.11.24.
//

struct ApiResponseEvent: Decodable {
    let results: [Event]
}

struct Event: Decodable {
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
}

struct EventImage: Decodable {
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
    }
}

struct EventDate: Decodable {
    let start: Int?
    let end: Int?
}

struct Place: Decodable {
    let title: String?
    let address: String?
    let coords: Coords?
}

struct Coords: Decodable {
    let lat: Double?
    let lon: Double?
}

struct Participants: Decodable {
    let role: Role?
    let agent: Agent?
}

struct Role: Decodable {
    let name: String?
}

struct Agent: Decodable {
    let title: String?
    let image: [EventImage]?
}

struct Category: Decodable {
    let slug: String?
    let name: String?
}

struct Location: Decodable {
    let slug: String?
    let name: String?
    let timezone: String?
    let coords: Coords?
    let language: String?
    let currency: String?
}
