//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

internal func GetMask(bits: UInt8) -> Int64 {
    (1 << bits) - 1
}

internal func waitUntilNextTimestamp(currentTimestamp: Int64) -> Int64 {
    var nextTimestamp = generateTimestamp(for: Date())
    while nextTimestamp <= currentTimestamp {
        nextTimestamp = generateTimestamp(for: Date())
    }
    return nextTimestamp
}

internal func generateTimestamp(for dateTime: Date, useUtc: Bool = true) -> Int64 {
    let calendar = Calendar.current
    let components = DateComponents(year: 1970, month: 1, day: 1, hour: 0, minute: 0, second: 0)
    let unixEpoch = calendar.date(from: components)!
    
    let timeInterval: TimeInterval
    if useUtc {
        timeInterval = dateTime.timeIntervalSince(unixEpoch)
    } else {
        timeInterval = dateTime.timeIntervalSince(unixEpoch) + TimeInterval(TimeZone.current.secondsFromGMT())
    }
    
    return Int64(timeInterval * 1000)
}
