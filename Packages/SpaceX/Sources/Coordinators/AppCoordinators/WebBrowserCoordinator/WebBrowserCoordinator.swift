//
//  WebBrowserCoordinator.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import SceneWebBrowser
import UIKit

final class WebBrowserCoordinator: NavigationCoordinator {
    // MARK: - Properties
    
    private let url: URL
    
    // MARK: - Constructor
    
    init(url: URL, navigation: UINavigationController) {
        self.url = url
        super.init(navigation: navigation)
    }
    
    // MARK: - Start
    
    override func start() {
        let viewModel = WebBrowserViewModel(url: url)
        viewModel.sceneDelegate = self
        let viewController = WebBrowserViewController(viewModel: viewModel)
        navigation.pushViewController(viewController, animated: true)
    }
}

// MARK: - WebBrowserSceneDelegate

extension WebBrowserCoordinator: WebBrowserSceneDelegate {
    func didTapDoneButton() {
        navigation.popViewController(animated: true)
        childDidFinish(self)
    }
}
