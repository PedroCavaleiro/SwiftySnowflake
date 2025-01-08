//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

public class Snowflake {
    
    public let snowflakeId: Int64
    public var timestamp: Int64
    public var machineId: Int
    public var sequence: Int
    
    fileprivate var configuration: Configuration
    
    fileprivate let maskTime = GetMask(bits: 41)
    fileprivate let maskGenerator = GetMask(bits: 10)
    fileprivate let maskSequence = GetMask(bits: 12)
    fileprivate let shiftTime = 22
    
    /// Initializes a new instance using a snowflake ID and an optional configuration.
    ///
    /// - Parameters:
    ///   - snowflakeId: The snowflake ID as an `Int64`.
    ///   - configuration: The configuration to use for creating the instance. Defaults to a new `Configuration` instance.
    init(_ snowflakeId: Int64, configuration: Configuration = Configuration()) {
        self.snowflakeId = snowflakeId
        self.timestamp = 0
        self.machineId = 0
        self.sequence = 0
        self.configuration = configuration
        decodeSnowflake(snowflakeId)
    }
    
    /// Initializes a new instance using a snowflake ID string and an optional configuration.
    ///
    /// - Parameters:
    ///   - snowflakeId: The snowflake ID as a `String`.
    ///   - configuration: The configuration to use for creating the instance. Defaults to a new `Configuration` instance.
    init(_ snowflakeId: String, configuration: Configuration = Configuration()) {
        self.snowflakeId = Int64(snowflakeId) ?? 0
        self.timestamp = 0
        self.machineId = 0
        self.sequence = 0
        self.configuration = configuration
        decodeSnowflake(Int64(snowflakeId) ?? 0)
    }
    
    /// A computed property that returns the timestamp as a `Date` object.
    ///
    /// - Returns: A `Date` object representing the timestamp.
    public var time: Date {
        return timestampToDateTime(timestamp)
    }
    
    /// Updates the configuration and decodes the snowflake ID.
    ///
    /// - Parameter configuration: The new configuration to set.

    public func updateConfiguration(_ configuration: Configuration) {
        self.configuration = configuration
        decodeSnowflake(self.snowflakeId)
    }
    
    /// Decodes the snowflake ID into its components.
    ///
    /// - Parameter snowflake: The snowflake ID to decode.
    private func decodeSnowflake(_ snowflake: Int64) {
        timestamp = (snowflake >> shiftTime) + configuration.epoch
        machineId = Int((snowflake >> Configuration.machineSequenceBits) & maskGenerator)
        sequence = Int(snowflake & maskSequence)
    }

    /// Converts a timestamp to a `Date` object.
    ///
    /// - Parameter timestamp: The timestamp to convert.
    /// - Returns: A `Date` object representing the timestamp.
    private func timestampToDateTime(_ timestamp: Int64) -> Date {
        let epoch = Date(timeIntervalSince1970: TimeInterval(configuration.epoch) / 1000)
        let dateTime = epoch.addingTimeInterval(TimeInterval(timestamp) / 1000)
        return configuration.alwaysUseUtc ? dateTime : dateTime.toLocalTime()
    }
    
}
