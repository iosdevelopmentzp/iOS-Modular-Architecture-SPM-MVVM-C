//
//  SortField.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

public enum Direction: String, Encodable {
    case asc = "asc"
    case desc = "desc"
}

struct SortField: Encodable {
    let fieldName: String
    let direction: Direction
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKey.self)
        try container.encode(direction.rawValue, forKey: .init(key: fieldName))
    }
}
