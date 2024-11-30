//
//  FormatterService.swift
//  EventHub
//
//  Created by nikita on 30.11.24.
//

import Foundation

final class FormatterService {
    static let shared = FormatterService()
    
    private init() {}
    
    func dateToString(_ dates: [EventDate]?, _ format: String) -> (start: String, end: String) {
        let eventDate = dates?.sorted(by: { lhs, rhs in
            lhs.start ?? 0 < rhs.start ?? 0
        })
        var nextDate: Int? = eventDate?.last?.end
        
        for date in eventDate ?? [] {
            if date.end ?? 0 > Int(Date().timeIntervalSince1970) {
                nextDate = date.end
                break
            }
        }
        
        if let unixTime = nextDate {
            let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, YYYY MMM d • h:mm a"
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            return dateFormatter.string(from: date)
        } else {
            return ("Date and time unknown", "Date and time unknown")
        }

    }
}
