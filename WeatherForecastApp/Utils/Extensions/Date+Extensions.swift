//
//  Date+Extensions.swift
//  WeatherForecastApp
//
//  Created by Amali Krigger on 10/29/23.
//

import Foundation

extension Date {
    static func dateFromUnixTimestamp(_ timestamp: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: timestamp)
    }

    func formattedDateString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func formattedWeekdayTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }

    func formattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current  // Use the current time zone
        return dateFormatter.string(from: self)
    }

    func abbreviatedWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.timeZone = TimeZone.current  // Use the current time zone
        return dateFormatter.string(from: self)
    }

}
