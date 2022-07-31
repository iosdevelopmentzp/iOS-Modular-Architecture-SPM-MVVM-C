//
//  AppCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import UIKit

public final class AppCoordinator: NavigationCoordinator {
    // MARK: - Properties
    
    private let window: UIWindow
    
    // MARK: - Constructor
    
    public init(window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .white
        super.init(navigation: navigationController)
    }
    
    // MARK: - Constructor
    
    public override func start() {
        window.rootViewController = navigation
        let launches = LaunchesCoordinator(navigation: navigation)
        addChild(launches)
        launches.start()
        window.makeKeyAndVisible()
    }
}
