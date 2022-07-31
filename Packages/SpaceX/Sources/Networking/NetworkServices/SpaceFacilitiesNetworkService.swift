//
//  SpaceFacilitiesNetworkService.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Core

public protocol SpaceFacilitiesNetworkServiceType {
    func loadRockets(filter: Encodable) async throws -> [RocketDTO]
}

final class SpaceFacilitiesNetworkService {
    // MARK: - Properties
    
    private let network: Networking
    private let targetFactory: TargetFactory<SpaceFacilitiesTarget>
    
    // MARK: - Constructor
    
    init(network: Networking, host: String, apiVersion: String) {
        self.network = network
        self.targetFactory = .init(host: host, apiVersion: apiVersion)
    }
}

// MARK: - SpaceCompanyNetworkServiceType

extension SpaceFacilitiesNetworkService: SpaceFacilitiesNetworkServiceType {
    func loadRockets(filter: Encodable) async throws -> [RocketDTO] {
        let target = targetFactory.make(endpoint: .rockets(parameters: filter.toDictionary))
        let response: QueryResponseDTO<RocketDTO> = try await network.perform(target: target)
        return response.docs
    }
}
