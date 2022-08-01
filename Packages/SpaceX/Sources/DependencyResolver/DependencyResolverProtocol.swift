//
//  DependencyResolverProtocol.swift
//  
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation

public protocol DependencyResolverProtocol {
    func resolve<Service>() -> Service
}
