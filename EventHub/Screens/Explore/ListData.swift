//
//  ListData.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 18.11.2024.
//

import Foundation

struct ListData {
    
    static let shared = ListData()
    
    private let event: ListSection = {
        .event([.init(title: "some party", image: "1", place: "ny"),
                .init(title: "another party", image: "2", place: "de"),
                .init(title: "party", image: "3", place: "mow")])
    }()
    
    private let nearby: ListSection = {
        .nearby([.init(title: "work", image: "3", place: ""),
                 .init(title: "concert in Moscow", image: "2", place: ""),
                 .init(title: "Lazy boy", image: "1", place: "")])
    }()
    
    var pageData: [ListSection] {
        [event, nearby]
    }
}

/*
import Foundation
 
// MARK: - ListData
struct ListData: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let title, slug: String
    let images: [Image]
}

// MARK: - Image
struct Image: Codable {
    let image: String
}
*/
