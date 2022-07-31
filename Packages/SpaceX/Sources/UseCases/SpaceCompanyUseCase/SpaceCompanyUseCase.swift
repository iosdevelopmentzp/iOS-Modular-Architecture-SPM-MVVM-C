//
//  SpaceCompanyUseCase.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Networking
import Core
import QueryFilterBuilder
import Extensions

final class SpaceCompanyUseCase {
    // MARK: - Properties
    
    private let spaceCompanyNetwork: SpaceCompanyNetworkServiceType
    private let spaceFacilitiesNetwork: SpaceFacilitiesNetworkServiceType
    
    // MARK: - Constructor
    
    init(
        spaceCompanyNetwork: SpaceCompanyNetworkServiceType,
        spaceFacilitiesNetwork: SpaceFacilitiesNetworkServiceType
    ) {
        self.spaceCompanyNetwork = spaceCompanyNetwork
        self.spaceFacilitiesNetwork = spaceFacilitiesNetwork
    }
}

// MARK: - SpaceCompanyUseCaseProtocol

extension SpaceCompanyUseCase: SpaceCompanyUseCaseProtocol {
    func loadCompanyInfo() async throws -> CompanyInfo {
        let companyInfo = try await spaceCompanyNetwork.loadCompanyInfo()
        return .init(
            name: companyInfo.name,
            founderName: companyInfo.founder,
            yearOfFoundation: companyInfo.founded,
            employeesCount: companyInfo.employees,
            launchSitesCount: companyInfo.launchSites,
            valuation: companyInfo.valuation
        )
    }
    
    func loadLaunches(options: LaunchesFilterOptions) async throws -> [Launch] {
        let launches = try await spaceCompanyNetwork.loadLaunches(
            filter: Self.makeLaunchesFilter(options: options)
        )
        
        var rockets: [RocketDTO] = []
        let rocketIds = launches.compactMap(\.rocket)
        
        if !rocketIds.isEmpty {
            rockets = try await spaceFacilitiesNetwork.loadRockets(
                filter: Self.makeRocketsFilter(ids: rocketIds)
            )
        }
        
        return LaunchesBuilder(launches: launches, rockets: rockets).build()
    }
}

// MARK: - Build Filters

private extension SpaceCompanyUseCase {
    private static func makeRocketsFilter(ids: [String]) -> Encodable {
        FilterBuilder()
            .setPaginationOptions(limit: 1000)
            .setFieldsToReturn(RocketDTO.CodingKeys.allCases.map(\.rawValue))
            .setInFilter(for: RocketDTO.CodingKeys.id.rawValue, values: ids)
            .build()
    }
    
    private static func makeLaunchesFilter(options: LaunchesFilterOptions) -> Encodable {
        let sortDirection: Direction = options.sorting == .asc ? .asc : .desc
        
        var builder = FilterBuilder()
            .setPaginationOptions(limit: 1000) // Crunches to avoid the need using pagination.
            .setFieldsToReturn(LaunchDTO.CodingKeys.allCases.map(\.rawValue))
            .setSort(fieldName: LaunchDTO.CodingKeys.dateUtc.rawValue, direction: sortDirection)
            .setPaginationMode(enabled: false)
            
        if let isSuccess = options.isLaunchSuccess {
            builder = builder.setEqualFilter(
                for: LaunchDTO.CodingKeys.success.rawValue,
                equalTo: isSuccess
            )
        }
        
        if let dateInterval = options.launchDateInterval {
            let dateFormatter = DateFormatter.api
            let lowerString = dateFormatter.string(from: dateInterval.start)
            let upperString = dateFormatter.string(from: dateInterval.end)
            builder = builder.setRangeFilter(
                for: LaunchDTO.CodingKeys.dateUtc.rawValue,
                range: (lowerString, upperString)
            )
        }
        
        return builder.build()
    }
}
