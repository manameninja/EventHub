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
        let nextDate: EventDate? = eventDate?.last
        
        if let startDate = nextDate?.start, let endDate = nextDate?.end {
            let startDateUnix = Date(timeIntervalSince1970: TimeInterval(startDate))
            let endDateUnix = Date(timeIntervalSince1970: TimeInterval(endDate))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone.current
            return (dateFormatter.string(from: startDateUnix), dateFormatter.string(from: endDateUnix))
        } else {
            return ("Date and time unknown", "Date and time unknown")
        }

    }
}
