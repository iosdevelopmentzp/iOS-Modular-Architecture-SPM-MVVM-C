//
//  DependencyResolver.swift
//  
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation
import Swinject
import Assemblies

public final class DependencyResolver {
    // MARK: - Properties
    
    private let assembler = Assembler()
    
    private var assemblies: [Assembly] {
        let factory = AssembliesFactory()
        return [
            factory.networking,
            factory.useCases
        ]
    }
    
    // MARK: - Constructor
    
    public init() {
        assembler.apply(assemblies: assemblies)
    }
}

// MARK: - DependencyResolverProtocol

extension DependencyResolver: DependencyResolverProtocol {
    public func resolve<Service>() -> Service {
        guard let service = assembler.resolver.resolve(Service.self) else {
            fatalError("Failed \(Service.self) resolve attempt")
        }
        return service
    }
}

// MARK: - DependencyRegisterProtocol

extension DependencyResolver: DependencyRegisterProtocol {
    public func append(assembly: Assembly) {
        assembler.apply(assembly: assembly)
    }
}