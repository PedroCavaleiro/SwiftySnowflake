//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

extension String {
    
    /// Converts the current object to a Snowflake instance using the provided configuration.
    ///
    /// - Parameter configuration: The configuration to use for creating the Snowflake instance.
    /// - Returns: A `Snowflake` instance configured with the specified `configuration`.
    public func toSnowflake(_ configuration: Configuration) -> Snowflake {
        Snowflake(self, configuration: configuration)
    }
    
    /// Converts the current object to a Snowflake instance using the specified configuration.
    ///
    /// - Parameter useGlobalConfiguration: A Boolean value indicating whether to use the global configuration.
    ///   - `true` to use the global configuration from `SwiftySnowflake.shared.configuration`.
    ///   - `false` to use a new instance of `Configuration`.
    /// - Returns: A `Snowflake` instance configured based on the `useGlobalConfiguration` parameter.
    public func toSnowflake(useGlobalConfiguration: Bool = true) -> Snowflake {
        if useGlobalConfiguration {
            return Snowflake(self, configuration: SwiftySnowflake.shared.configuration)
        } else {
            return Snowflake(self, configuration: Configuration())
        }
    }
}
