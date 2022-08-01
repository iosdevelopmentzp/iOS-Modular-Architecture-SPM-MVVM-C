//
//  APIConfigurationAssembly.swift
//  
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Swinject
import Networking

struct APIConfigurationAssembly: Assembly {
    
    private let provider: () -> (NetworkApiConfigurationProtocol)
    
    init(_ provider: @escaping () -> (NetworkApiConfigurationProtocol)) {
        self.provider = provider
    }
    
    func assemble(container: Container) {
        container.register(NetworkApiConfigurationProtocol.self) { _ in
            provider()
        }.inObjectScope(.container)
    }
}
