//
//  LaunchDTO.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public struct LaunchDTO: Decodable, Equatable {
    public enum CodingKeys: String, CodingKey, CaseIterable {
        case id
        case name
        case dateUtc = "date_utc"
        case rocket
        case success
        case links
    }
    
    public struct Links: Decodable, Equatable {
        public let patch: Patch?
        public let wikipedia: String?
        public let article: String?
        public let youtubeId: String?
    }
    
    public struct Patch: Decodable, Equatable {
        public let small: String?
        public let large: String?
    }
    
    public let id: String
    public let name: String?
    public let dateUtc: Date?
    public let rocket: String?
    public let success: Bool?
    public let links: Links?
}
