//
//  LaunchesFiltersSceneDelegate.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation

public protocol LaunchesFiltersSceneDelegate: AnyObject {
    func dismissScene()
    func didTapConfirm(with filters: [LaunchesFilter])
}
