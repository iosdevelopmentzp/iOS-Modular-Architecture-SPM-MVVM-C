//
//  UseCasesAssembly.swift
//  
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import UseCases
import Swinject
import Networking

struct UseCasesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UseCasesFactoryProtocol.self) { _ in
            UseCasesFactory()
        }.inObjectScope(.container)
        
        container.register(SpaceCompanyUseCaseProtocol.self) { resolver in
            guard
                let factory = resolver.resolve(UseCasesFactoryProtocol.self),
                let spaceNetwork = resolver.resolve(SpaceCompanyNetworkServiceType.self),
                let facilitiesNetwork = resolver.resolve(SpaceFacilitiesNetworkServiceType.self)
            else {
                fatalError("Failed UseCasesFactoryProtocol resolving attempt")
            }
            
            return factory.spaceCompanyUseCase(
                spaceCompanyNetwork: spaceNetwork,
                spaceFacilitiesNetwork: facilitiesNetwork
            )
        }
    }
}
