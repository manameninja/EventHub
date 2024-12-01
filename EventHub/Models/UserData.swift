//
//  UserData.swift
//  EventHub
//
//  Created by Даниил Павленко on 01.12.2024.
//

import Foundation

struct UserData: Codable {
    let id: Int
    let photo: Data
    let name: String
    let description: String
}
