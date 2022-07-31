//
//  UseCasesFactory.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Networking

public protocol UseCasesFactoryProtocol {
    var spaceCompanyUseCase: SpaceCompanyUseCaseProtocol { get }
}

public final class UseCasesFactory {
    // MARK: - Properties
    
    private let networkFactory: NetworkServicesFactoryType
    
    // MARK: - Constructor
    
    public init(networkFactory: NetworkServicesFactoryType) {
        self.networkFactory = networkFactory
    }
}

// MARK: - UseCasesFactoryProtocol

extension UseCasesFactory: UseCasesFactoryProtocol {
    public var spaceCompanyUseCase: SpaceCompanyUseCaseProtocol {
        SpaceCompanyUseCase(
            spaceCompanyNetwork: networkFactory.spaceCompanyService,
            spaceFacilitiesNetwork: networkFactory.spaceFacilitiesService
        )
    }
}
