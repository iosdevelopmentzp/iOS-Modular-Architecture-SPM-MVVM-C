//
//  NetworkingAssembly.swift
//  
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Swinject
import Networking

struct NetworkingAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(NetworkServicesFactoryType.self) { resolver in
            guard let networkConfiguration = resolver.resolve(NetworkApiConfigurationProtocol.self) else {
                fatalError("Failed NetworkApiConfigurationProtocol resolving attempt")
            }
            return NetworkServicesFactory(configuration: networkConfiguration)
        }.inObjectScope(.container)
        
        container.register(SpaceCompanyNetworkServiceType.self) { resolver in
            guard let factory = resolver.resolve(NetworkServicesFactoryType.self) else {
                fatalError("Failed NetworkServicesFactoryType resolving attempt")
            }
            return factory.spaceCompanyService
        }
        
        container.register(SpaceFacilitiesNetworkServiceType.self) { resolver in
            guard let factory = resolver.resolve(NetworkServicesFactoryType.self) else {
                fatalError("Failed NetworkServicesFactoryType resolving attempt")
            }
            return factory.spaceFacilitiesService
        }
    }
}
