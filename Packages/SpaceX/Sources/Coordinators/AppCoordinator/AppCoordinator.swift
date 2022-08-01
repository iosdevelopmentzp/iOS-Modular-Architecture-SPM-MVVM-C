//
//  AppCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import UIKit
import DependencyResolver

public final class AppCoordinator: NavigationCoordinator {
    // MARK: - Properties
    
    private let window: UIWindow
    
    private let resolver: DependencyResolverProtocol
    
    // MARK: - Constructor
    
    public init(window: UIWindow, resolver: DependencyResolverProtocol) {
        self.window = window
        self.resolver = resolver
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .white
        super.init(navigation: navigationController)
    }
    
    // MARK: - Constructor
    
    public override func start() {
        window.rootViewController = navigation
        let launches = LaunchesCoordinator(navigation: navigation, resolver: resolver)
        addChild(launches)
        launches.start()
        window.makeKeyAndVisible()
    }
}
