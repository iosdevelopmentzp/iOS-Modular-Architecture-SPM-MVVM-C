//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Dmytro Vorko on 31.07.2022.
//

import UIKit
import Coordinators
import DependencyResolver
import Assemblies

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        let appCoordinator = AppCoordinator(window: window, resolver: setupDependencyResolver())
        self.appCoordinator = appCoordinator
        appCoordinator.start()
    }
}

// MARK: - Private Functions

private extension SceneDelegate {
    private func setupDependencyResolver() -> DependencyResolverProtocol {
        let resolver = DependencyResolver()
        
        let assemblyFactory = AssembliesFactory()
        
        resolver.append(assemblies: [
            assemblyFactory.useCases,
            assemblyFactory.networking,
            assemblyFactory.apiConfiguration(ApiConfiguration())
        ])
        return resolver
    }
}
