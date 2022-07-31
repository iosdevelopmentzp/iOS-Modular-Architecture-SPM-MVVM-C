//
//  EquelCondition.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

final class SimpleTypeCondition<T: Encodable>: Condition {
    let value: T
    
    init(value: T) {
        self.value = value
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
