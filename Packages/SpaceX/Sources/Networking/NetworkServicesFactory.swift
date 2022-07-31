//
//  NetworkServicesFactory.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public protocol NetworkServicesFactoryType {
    var spaceCompanyService: SpaceCompanyNetworkServiceType { get }
    var spaceFacilitiesService: SpaceFacilitiesNetworkServiceType { get }
}

public final class NetworkServicesFactory {
    // MARK: - Properties
    
    private let configuration: NetworkApiConfigurationProtocol

    // MARK: - Constructor
    
    public init(configuration: NetworkApiConfigurationProtocol) {
        self.configuration = configuration
    }
}

// MARK: - NetworkServicesFactoryType

extension NetworkServicesFactory: NetworkServicesFactoryType {
    public var spaceCompanyService: SpaceCompanyNetworkServiceType {
        SpaceCompanyNetworkService(
            network: Networking(),
            host: configuration.host,
            apiVersion: configuration.apiVersion
        )
    }
    
    public var spaceFacilitiesService: SpaceFacilitiesNetworkServiceType {
        SpaceFacilitiesNetworkService(
            network: Networking(),
            host: configuration.host,
            apiVersion: configuration.apiVersion
        )
    }
}
