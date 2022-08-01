//
//  DependencyRegisterProtocol.swift
//  
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Swinject

public protocol DependencyRegisterProtocol {
    func append(assembly: Assembly)
}
