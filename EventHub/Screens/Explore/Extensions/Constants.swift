//
//  Constants.swift
//  EventHub
//
//  Created by Alexander Bokhulenkov on 29.11.2024.
//

import UIKit

enum CategoryImage {
    case cinema
    case concert
    case education
    case entertainment
    case exhibition
    case fashion
    case festival
    case holiday
    case kids
    case other
    case party
    case photo
    case quest
    case recreation
    case shopping
    case stock
    case theater
    case tour

    var image: UIImage? {
        switch self {
        case .cinema:
            return UIImage(systemName: "film.circle")
        case .concert:
            return UIImage(systemName: "theatermasks.circle")
        case .education:
            return UIImage(systemName: "book.circle")
        case .entertainment:
            return UIImage(systemName: "party.popper")
        case .exhibition:
            return UIImage(systemName: "building.columns.circle")
        case .fashion:
            return UIImage(systemName: "eyebrow")
        case .festival:
            return UIImage(systemName: "flag.2.crossed.circle")
        case .holiday:
            return UIImage(systemName: "globe.americas.fill")
        case .kids:
            return UIImage(systemName: "figure.walk.motion")
        case .other:
            return UIImage(systemName: "accessibility")
        case .party:
            return UIImage(systemName: "party.popper")
        case .photo:
            return UIImage(systemName: "camera.circle")
        case .quest:
            return UIImage(systemName: "stopwatch")
        case .recreation:
            return UIImage(systemName: "sun.max.circle.fill")
        case .shopping:
            return UIImage(systemName: "cart")
        case .stock:
            return UIImage(systemName: "camera.metering.unknown")
        case .theater:
            return UIImage(systemName: "theatermasks.circle")
        case .tour:
            return UIImage(systemName: "storefront")
        }
    }
    
}

enum K {
    static let avatarSize: CGFloat = 24
    static let imagePin = UIImage(named: "map-pin")
    static let imageBookmark = UIImage(named: "bookmark")
    static let imageBookmarkFill = UIImage(named: "bookmarkFill")
    static let topAvatarImage = UIImage(named: "woomen")
    static let middleAvatarImage = UIImage(named: "woomen")
    static let bottomAvatarImage = UIImage(named: "manbottom")
    static let bell = UIImage(named: "bell")
}
