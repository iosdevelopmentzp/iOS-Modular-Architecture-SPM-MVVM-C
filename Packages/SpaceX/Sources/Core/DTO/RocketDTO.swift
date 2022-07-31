//
//  RocketDTO.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public struct RocketDTO: Decodable, Equatable {
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case type
    }
    
    public let id: String
    public let name: String?
    public let type: String?
}
