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

// TODO: - Use DI for main app configurations injection
struct Configuration: NetworkApiConfigurationProtocol {
    var host: String { "api.spacexdata.com" }
    
    var apiVersion: String { "v4" }
}

final class LaunchesCoordinator: NavigationCoordinator {
    private var filtersCompletion: (([LaunchesFilter]) -> Void)?
    
    override func start() {
        Task {
            let networkFactory = NetworkServicesFactory(configuration: Configuration())
            // TODO: - Use DI
            let useCase = UseCasesFactory(networkFactory: networkFactory).spaceCompanyUseCase
            let viewModel = await LaunchesViewModel(useCase: useCase, sceneDelegate: self)
            let view = await LaunchesViewController(viewModel: viewModel)
            await navigation.pushViewController(view, animated: false)
        }
    }
}

// MARK: - LaunchesSceneDelegate

extension LaunchesCoordinator: LaunchesSceneDelegate {
    func routeToFilters(_ current: [LaunchesFilter], completion: @escaping ([LaunchesFilter]) -> Void) {
        self.filtersCompletion = completion
        
        Task {
            let viewModel = await LaunchesFiltersViewModel(filters: current, sceneDelegate: self)
            let viewController = await LaunchesFiltersViewController(viewModel: viewModel)
            await navigation.present(viewController, animated: true)
        }
    }
    
    func routeToWeb(with url: URL) {
        let coordinator = WebBrowserCoordinator(url: url, navigation: self.navigation)
        addChild(coordinator)
        coordinator.start()
    }
}

// MARK: - LaunchesFiltersSceneDelegate

extension LaunchesCoordinator: LaunchesFiltersSceneDelegate {
    func dismissScene() {
        (navigation.presentedViewController as? LaunchesFiltersViewController)?.dismiss(animated: true)
    }
    
    func didTapConfirm(with filters: [LaunchesFilter]) {
        (navigation.presentedViewController as? LaunchesFiltersViewController)?.dismiss(animated: true)
        filtersCompletion?(filters)
        filtersCompletion = nil
    }   
}
