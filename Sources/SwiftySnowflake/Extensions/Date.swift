//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

extension Date {
    func toLocalTime() -> Date {
        let timezoneOffset = TimeInterval(TimeZone.current.secondsFromGMT(for: self))
        return addingTimeInterval(timezoneOffset)
    }
}
