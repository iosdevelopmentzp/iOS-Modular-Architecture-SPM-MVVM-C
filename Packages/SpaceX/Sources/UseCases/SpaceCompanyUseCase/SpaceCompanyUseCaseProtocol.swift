//
//  SpaceCompanyUseCaseProtocol.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation
import Core

public struct LaunchesFilterOptions {
    public enum Sorting {
        case asc
        case desc
    }
    
    let isLaunchSuccess: Bool?
    let launchDateInterval: DateInterval?
    let sorting: Sorting
    
    public init(
        isLaunchSuccess: Bool?,
        launchDateInterval: DateInterval?,
        sorting: LaunchesFilterOptions.Sorting
    ) {
        self.isLaunchSuccess = isLaunchSuccess
        self.launchDateInterval = launchDateInterval
        self.sorting = sorting
    }
}

public protocol SpaceCompanyUseCaseProtocol {
    func loadCompanyInfo() async throws -> CompanyInfo
    func loadLaunches(options: LaunchesFilterOptions) async throws -> [Launch]
}
