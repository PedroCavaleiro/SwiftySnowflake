//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

public class Snowflake {
    
    init(_ snowflakeId: Int64, configuration: Configuration = Configuration(), timestamp: Int64 = 0, machineId: Int = 0, sequence: Int = 0) {
        self.snowflakeId = snowflakeId
        self.timestamp = timestamp
        self.machineId = machineId
        self.sequence = sequence
        self.configuration = configuration
        decodeSnowflake(snowflakeId)
    }
    
    init(_ snowflakeId: String, configuration: Configuration = Configuration(), timestamp: Int64 = 0, machineId: Int = 0, sequence: Int = 0) {
        self.snowflakeId = Int64(snowflakeId) ?? 0
        self.timestamp = timestamp
        self.machineId = machineId
        self.sequence = sequence
        self.configuration = configuration
        decodeSnowflake(Int64(snowflakeId) ?? 0)
    }
    
    public let snowflakeId: Int64
    public var timestamp: Int64
    public var machineId: Int
    public var sequence: Int
    
    fileprivate var configuration: Configuration
    
    fileprivate let maskTime = GetMask(bits: 41)
    fileprivate let maskGenerator = GetMask(bits: 10)
    fileprivate let maskSequence = GetMask(bits: 12)
    fileprivate let shiftTime = 22
    
    public var time: Date {
        return timestampToDateTime(timestamp)
    }
    
    public func updateConfiguration(_ configuration: Configuration) {
        self.configuration = configuration
    }
    
    private func decodeSnowflake(_ snowflake: Int64) {
        timestamp = (snowflake >> shiftTime) & maskTime
        machineId = Int((snowflake >> Configuration.machineSequenceBits) & maskGenerator)
        sequence = Int(snowflake & maskSequence)
    }

    private func timestampToDateTime(_ timestamp: Int64) -> Date {
        let epoch = Date(timeIntervalSince1970: TimeInterval(configuration.epoch) / 1000)
        let dateTime = epoch.addingTimeInterval(TimeInterval(timestamp) / 1000)
        return configuration.alwaysUseUtc ? dateTime : dateTime.toLocalTime()
    }
    
}
