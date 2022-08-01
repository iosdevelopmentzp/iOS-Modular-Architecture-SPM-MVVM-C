//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Dmytro Vorko on 31.07.2022.
//

import UIKit
import Coordinators
import DependencyResolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        let appCoordinator = AppCoordinator(window: window, resolver: initializeDependencyResolver())
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}

// MARK: - Private Functions

private extension SceneDelegate {
    private func initializeDependencyResolver() -> DependencyResolverProtocol {
        let resolver = DependencyResolver()
        resolver.append(assembly: ApiConfigurationAssembly())
        return resolver
    }
}
