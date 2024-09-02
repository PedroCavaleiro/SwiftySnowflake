//
//  File.swift
//  
//
//  Created by Pedro Cavaleiro on 02/09/2024.
//

import Foundation

extension String {
    func toSnowflake(configuration: Configuration = Configuration()) -> Snowflake {
        Snowflake(self, configuration: configuration)
    }
}
