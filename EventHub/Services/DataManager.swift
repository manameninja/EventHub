//
//  DataManager.swift
//  EventHub
//
//  Created by nikita on 19.11.24.
//

import Foundation

enum Link: String {
    case categories = "https://kudago.com/public-api/v1.4/event-categories/?lang=en"
    case locations = "https://kudago.com/public-api/v1.4/locations/?lang=en&fields=slug,name,timezone,coords,language,currency"
    case search = "https://kudago.com/public-api/v1.4/search/?q="
    case events = "https://kudago.com/public-api/v1.4/events/?lang=en&fields=id,dates,short_title,place,body_text,location,price,images,favorites_count,site_url,participants&expand=price,dates,place,location,participants&text_format=text"
}

final class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func getCategories(completion: @escaping ([Category]) -> Void) {
        let url = Link.categories.rawValue
        NetworkManager.shared.fetch([Category].self, from: url) { result in
            switch result {
            case .success(let categories):
                completion(categories)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getLocations(completion: @escaping ([Location]) -> Void) {
        let url = Link.locations.rawValue
        NetworkManager.shared.fetch([Location].self, from: url) { result in
            switch result {
            case .success(let locations):
                completion(locations)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getEvents(
        category: String = "",
        location: String = "",
        startTime: Int = Int(Date().timeIntervalSince1970),
        lat: Double? = nil,
        lon: Double? = nil,
        radius: Int? = nil, //in meters
        pageSize: Int = 100,
        page: Int = 1,
        completion: @escaping ([Event]) -> Void
    ) {
        let lat = lat == nil ? "" : String(lat ?? 0.0)
        let lon = lon == nil ? "" : String(lon ?? 0.0)
        let radius = radius == nil ? "" : String(radius ?? 0)
        
        let url = Link.events.rawValue
                + "&categories=\(category)"
                + "&location=\(location)"
                + "&actual_since=\(startTime)"
                + "&lon=" + lon
                + "&lat=" + lat
                + "&radius=" + radius
                + "&page_size=\(pageSize)"
                + "&page=\(page)"
        
        NetworkManager.shared.fetch(ApiResponseEvent.self, from: url) { result in
            switch result {
            case .success(let apiResponse):
                completion(apiResponse.results)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}

