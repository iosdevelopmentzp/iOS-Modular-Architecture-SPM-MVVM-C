//
//  CompanyInfoDTO.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public struct CompanyInfoDTO: Decodable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case name
        case founder
        case founded
        case employees
        case launchSites = "launch_sites"
        case valuation
    }
    
    public let name: String
    public let founder: String
    public let founded: Int
    public let employees: Int
    public let launchSites: Int
    public let valuation: Int
}
