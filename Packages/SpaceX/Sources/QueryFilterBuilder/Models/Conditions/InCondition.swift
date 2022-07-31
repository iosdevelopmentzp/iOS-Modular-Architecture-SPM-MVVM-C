//
//  InCondition.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

final class InCondition: Condition {
    private enum CodingKeys: String, CodingKey {
        case values = "$in"
    }
    
    let values: [String]
    
    init(values: [String]) {
        self.values = values
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(values, forKey: .values)
    }
}
