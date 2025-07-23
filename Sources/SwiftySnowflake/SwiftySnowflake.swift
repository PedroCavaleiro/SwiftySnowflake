// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// A class that generates unique identifiers (Snowflakes) based on Twitter's Snowflake algorithm.
/// - Parameter configuration: The configuration for the Snowflake generator.
public class SwiftySnowflake {
    
    public static let shared = SwiftySnowflake()
    
    private let maxSequence: Int
    private var lastTimestamp: Int64 = -1
    private var sequence: Int64 = 0
    
    private let shiftTime = 10 + 12
    private let shiftGenerator = 12
    
    public private(set) var configuration: Configuration
    
    /// Configures the shared SwiftySnowflake instance with the provided configuration.
    ///
    /// - Parameter configuration: The configuration to set for the shared SwiftySnowflake instance.
    public static func configure(configuration: Configuration) {
        SwiftySnowflake.shared.configuration = configuration
    }

    /// Initialization with the default configuration
    public init(configuration: Configuration = Configuration()) {
        self.configuration = configuration
        self.maxSequence = (1 << Configuration.machineSequenceBits) - 1

        let currentTimestamp = generateTimestamp(for: configuration.alwaysUseUtc ? Date() : Date(), useUtc: configuration.alwaysUseUtc)
        if configuration.epoch > currentTimestamp {
            fatalError("Invalid epoch: \(configuration.epoch). It can't be greater than the current timestamp!")
        }
    }

    /// Generates the Snowflake ID
    /// - Returns: The Snowflake
    public func generateSnowflake() -> Int64 {
        var timestamp = generateTimestamp(for: configuration.alwaysUseUtc ? Date() : Date(), useUtc: configuration.alwaysUseUtc)

        if timestamp < lastTimestamp {
            fatalError("Clock is moving backwards!")
        }

        if timestamp == lastTimestamp {
            sequence = (sequence + 1) & Int64(maxSequence)
            if sequence == 0 {
                timestamp = waitUntilNextTimestamp(currentTimestamp: timestamp)
            }
        } else {
            sequence = 0
        }

        lastTimestamp = timestamp

        return ((timestamp - configuration.epoch) << shiftTime)
            | (Int64(configuration.workedId) << shiftGenerator)
            | sequence
    }
}
