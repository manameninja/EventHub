//
//  DataManager.swift
//  EventHub
//
//  Created by nikita on 19.11.24.
//

import Foundation

enum Link: String {
    case search = "https://kudago.com/public-api/v1.4/search/?q="
    case events = "https://kudago.com/public-api/v1.4/events/?lang=en&page_size=100"
}

final class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func getEvents(
        category: String = "",
        location: String = "",
        lon: Int? = nil,
        lat: Int? = nil,
        
        page: Int = 1,
        completion: @escaping ([Event]) -> Void
    ) {
        let url = Link.events.rawValue
                + "&categories=" + category
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

