//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

extension Int64 {
    func toSnowflake(configuration: Configuration = Configuration()) -> Snowflake {
        Snowflake(self, configuration: configuration)
    }
}
