//
//  UseCasesFactory.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Networking

public protocol UseCasesFactoryProtocol {
    func spaceCompanyUseCase(
        spaceCompanyNetwork: SpaceCompanyNetworkServiceType,
        spaceFacilitiesNetwork: SpaceFacilitiesNetworkServiceType
    ) -> SpaceCompanyUseCaseProtocol
}

public final class UseCasesFactory {
    // MARK: - Constructor
    
    public init() {}
}

// MARK: - UseCasesFactoryProtocol

extension UseCasesFactory: UseCasesFactoryProtocol {
    public func spaceCompanyUseCase(
        spaceCompanyNetwork: SpaceCompanyNetworkServiceType,
        spaceFacilitiesNetwork: SpaceFacilitiesNetworkServiceType
    ) -> SpaceCompanyUseCaseProtocol {
        SpaceCompanyUseCase(
            spaceCompanyNetwork: spaceCompanyNetwork,
            spaceFacilitiesNetwork: spaceFacilitiesNetwork
        )
    }
}
