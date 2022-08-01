//
//  NavigationCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import UIKit

open class NavigationCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    
    let navigation: UINavigationController
    public private(set) var children: [CoordinatorProtocol] = []
    
    // MARK: - Constructor
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    // MARK: - Functions
    
    @MainActor public func start() {
        fatalError("This method must be overridden")
    }
    
    public func addChild(_ child: CoordinatorProtocol) {
        children.append(child)
    }
    
    public func childDidFinish(_ child: CoordinatorProtocol) {
        children = children.filter { $0 !== child }
    }
}
