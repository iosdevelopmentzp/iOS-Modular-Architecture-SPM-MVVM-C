//
//  DynamicCodingKey.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

struct DynamicCodingKey {
    let key: String
}

extension DynamicCodingKey: CodingKey {
    var stringValue: String { key }
    
    var intValue: Int? { nil }
    
    init?(stringValue: String) {
        self.key = stringValue
    }
    
    init?(intValue: Int) {
        nil
    }
}
