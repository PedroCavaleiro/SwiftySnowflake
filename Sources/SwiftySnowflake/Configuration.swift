//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

/// Configuration for the Snowflake generator
public class Configuration {

    public let workedId: Int
    public let epoch: Int64
    public let alwaysUseUtc: Bool

    // These are according to spec and should not be changed
    internal static var timestampBits: Int { return 41 }
    internal static var machineIdBits: Int { return 10 }
    internal static var machineSequenceBits: Int { return 12 }

    /// Initializes the Snowflake Generator
    ///
    /// The default epoch timestamp is 1st of June of 2010 when Twitter announced Snowflake usage
    ///
    /// - Parameters:
    ///   - epoch: Epoch TimeStamp (in milliseconds) to start generating the Snowflakes
    ///   - workedId: Worker ID that is going to generate the Snowflakes
    ///   - alwaysUseUtc: Generates the timestamps in UTC (recommended)
    public init(epoch: Int64 = 1275350400000, workedId: Int = 1, alwaysUseUtc: Bool = true) {
        self.workedId = workedId
        self.epoch = epoch
        self.alwaysUseUtc = alwaysUseUtc
    }

    /// Initializes the Snowflake Generator
    ///
    /// - Parameters:
    ///   - epoch: Date where the Worker ID should start generating timestamps for the Snowflakes
    ///   - workedId: Worker ID that is going to generate the Snowflakes
    ///   - alwaysUseUtc: Generates the timestamps in UTC (recommended)
    public init(epoch: Date, workedId: Int = 1, alwaysUseUtc: Bool = true) {
        self.workedId = workedId
        self.alwaysUseUtc = alwaysUseUtc
        self.epoch = generateTimestamp(for: epoch, useUtc: alwaysUseUtc)
    }
}
