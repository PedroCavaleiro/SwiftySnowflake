//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

/// Returns a mask with the specified number of bits set to 1.
///
/// - Parameter bits: The number of bits to set to 1.
/// - Returns: An `Int64` value with the specified number of bits set to 1.
internal func GetMask(bits: UInt8) -> Int64 {
    (1 << bits) - 1
}

/// Waits until the next timestamp that is greater than the current timestamp.
///
/// - Parameter currentTimestamp: The current timestamp.
/// - Returns: The next timestamp that is greater than the current timestamp.
internal func waitUntilNextTimestamp(currentTimestamp: Int64) -> Int64 {
    var nextTimestamp = generateTimestamp(for: Date())
    while nextTimestamp <= currentTimestamp {
        nextTimestamp = generateTimestamp(for: Date())
    }
    return nextTimestamp
}

/// Generates a timestamp for the specified date.
///
/// - Parameters:
///   - dateTime: The date for which to generate the timestamp.
///   - useUtc: A Boolean value indicating whether to use UTC. Defaults to `true`.
/// - Returns: An `Int64` value representing the timestamp for the specified date.
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
