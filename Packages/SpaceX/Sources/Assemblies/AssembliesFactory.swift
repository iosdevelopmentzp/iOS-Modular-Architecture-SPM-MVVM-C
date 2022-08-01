//
//  AssembliesFactory.swift
//  
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation
import Swinject
import Networking

public protocol AssembliesFactoryProtocol {
    var networking: Assembly { get }
    var useCases: Assembly { get }
    
    func apiConfiguration(_ provider: @autoclosure @escaping () -> (NetworkApiConfigurationProtocol)) -> Assembly
}

public class AssembliesFactory {
    public init() {}
}

// MARK: - AssembliesFactoryProtocol

extension AssembliesFactory: AssembliesFactoryProtocol {
    public var networking: Assembly {
        NetworkingAssembly()
    }
    
    public var useCases: Assembly {
        UseCasesAssembly()
    }
    
    public func apiConfiguration(_ provider: @autoclosure @escaping () -> (NetworkApiConfigurationProtocol)) -> Assembly {
        APIConfigurationAssembly(provider)
    }
}
