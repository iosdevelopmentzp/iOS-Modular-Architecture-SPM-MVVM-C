//
//  LaunchesCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import SceneLaunches
import UseCases
import Networking
import UIKit
import DependencyResolver

// TODO: - Use DI for main app configurations injection
struct Configuration: NetworkApiConfigurationProtocol {
    var host: String { "api.spacexdata.com" }
    
    var apiVersion: String { "v4" }
}

final class LaunchesCoordinator: NavigationCoordinator {
    // MARK: - Properties
    
    private let resolver: DependencyResolverProtocol
    
    private var filtersCompletion: (([LaunchesFilter]) -> Void)?
    
    // MARK: - Constructor
    
    init(navigation: UINavigationController, resolver: DependencyResolverProtocol) {
        self.resolver = resolver
        super.init(navigation: navigation)
    }
    
    // MARK: - Start
    
    override func start() {
        let viewModel = LaunchesViewModel(useCase: resolver.resolve(), sceneDelegate: self)
        let view = LaunchesViewController(viewModel: viewModel)
        navigation.pushViewController(view, animated: false)
    }
}

// MARK: - LaunchesSceneDelegate

extension LaunchesCoordinator: LaunchesSceneDelegate {
    @MainActor func routeToFilters(
        _ current: [LaunchesFilter],
        completion: @escaping ([LaunchesFilter]) -> Void
    ) {
        self.filtersCompletion = completion
        let viewModel = LaunchesFiltersViewModel(filters: current, sceneDelegate: self)
        let viewController = LaunchesFiltersViewController(viewModel: viewModel)
        navigation.present(viewController, animated: true)
    }
    
    @MainActor func routeToWeb(with url: URL) {
        let coordinator = WebBrowserCoordinator(url: url, navigation: self.navigation)
        addChild(coordinator)
        coordinator.start()
    }
}

// MARK: - LaunchesFiltersSceneDelegate

extension LaunchesCoordinator: LaunchesFiltersSceneDelegate {
    @MainActor func dismissScene() {
        (navigation.presentedViewController as? LaunchesFiltersViewController)?.dismiss(animated: true)
    }
    
    @MainActor func didTapConfirm(with filters: [LaunchesFilter]) {
        (navigation.presentedViewController as? LaunchesFiltersViewController)?.dismiss(animated: true)
        filtersCompletion?(filters)
        filtersCompletion = nil
    }   
}
