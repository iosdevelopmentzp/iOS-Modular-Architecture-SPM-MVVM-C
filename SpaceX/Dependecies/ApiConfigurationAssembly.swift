//
//  ApiConfigurationAssembly.swift
//  SpaceX
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation
import Swinject
import Networking

struct ApiConfigurationAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkApiConfigurationProtocol.self) { _ in
            ApiConfiguration()
        }.inObjectScope(.container)
    }
}
