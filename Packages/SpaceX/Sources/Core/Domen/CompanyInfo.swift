//
//  CompanyInfo.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public struct CompanyInfo: Equatable {
    public let name: String
    public let founderName: String
    public let yearOfFoundation: Int
    public let employeesCount: Int
    public let launchSitesCount: Int
    public let valuation: Int
    
    public init(
        name: String,
        founderName: String,
        yearOfFoundation: Int,
        employeesCount: Int,
        launchSitesCount: Int,
        valuation: Int
    ) {
        self.name = name
        self.founderName = founderName
        self.yearOfFoundation = yearOfFoundation
        self.employeesCount = employeesCount
        self.launchSitesCount = launchSitesCount
        self.valuation = valuation
    }
}
