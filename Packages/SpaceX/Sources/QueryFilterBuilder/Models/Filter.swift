//
//  FilterCondition.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

class Condition: Encodable {}

struct Filter {
    let fieldName: String
    let condition: Condition
}
