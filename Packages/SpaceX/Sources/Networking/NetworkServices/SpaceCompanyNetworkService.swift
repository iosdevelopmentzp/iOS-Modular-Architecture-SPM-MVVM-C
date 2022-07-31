//
//  SpaceCompanyNetworkService.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Core

public protocol SpaceCompanyNetworkServiceType {
    func loadCompanyInfo() async throws -> CompanyInfoDTO
    func loadLaunches(filter: Encodable) async throws -> [LaunchDTO]
}

final class SpaceCompanyNetworkService {
    // MARK: - Properties
    
    private let network: Networking
    private let targetFactory: TargetFactory<SpaceCompanyTarget>
    
    // MARK: - Constructor
    
    init(network: Networking, host: String, apiVersion: String) {
        self.network = network
        self.targetFactory = .init(host: host, apiVersion: apiVersion)
    }
}

// MARK: - SpaceCompanyNetworkServiceType

extension SpaceCompanyNetworkService: SpaceCompanyNetworkServiceType {
    func loadCompanyInfo() async throws -> CompanyInfoDTO {
        let target = targetFactory.make(endpoint: .companyInfo)
        return try await network.perform(target: target)
    }
    
    func loadLaunches(filter: Encodable) async throws -> [LaunchDTO] {
        let target = targetFactory.make(endpoint: .launches(parameters: filter.toDictionary))
        let response: QueryResponseDTO<LaunchDTO> = try await network.perform(target: target)
        return response.docs
    }
}
