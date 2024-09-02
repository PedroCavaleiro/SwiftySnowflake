//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

extension String {
    public func toSnowflake(configuration: Configuration = Configuration()) -> Snowflake {
        Snowflake(self, configuration: configuration)
    }
}
