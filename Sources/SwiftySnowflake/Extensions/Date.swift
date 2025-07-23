//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

/// Date extensions
extension Date {

    /// Converts the date to local time based on the current time zone.
    /// - Returns: The local time representation of the date.
    public func toLocalTime() -> Date {
        let timezoneOffset = TimeInterval(TimeZone.current.secondsFromGMT(for: self))
        return addingTimeInterval(timezoneOffset)
    }
    
}
