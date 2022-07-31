//
//  RangeCondition.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

final class RangeCondition: Condition {
    enum CodingKeys: String, CodingKey {
        case lower = "$gte"
        case upper = "$lte"
    }
    
    let lower: String
    let upper: String
    
    init(lower: String, upper: String) {
        self.lower = lower
        self.upper = upper
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lower, forKey: .lower)
        try container.encode(upper, forKey: .upper)
    }
}
