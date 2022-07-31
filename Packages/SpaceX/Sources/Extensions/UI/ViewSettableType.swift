//
//  ViewSettableType.swift
//  
//
//  Created by Dmytro Vorko on 22.07.2022.
//

import Foundation

public protocol ViewSettableType {
    func setupViews()
    func addViews()
    func layoutViews()
}

public extension ViewSettableType {
    func performSetupViews() {
        setupViews()
        addViews()
        layoutViews()
    }
    
    func setupViews() {
        // Default Implementation
    }
    
    func addViews() {
        // Default Implementation
    }
    
    func layoutViews() {
        // Default Implementation
    }
}
