//
//  LaunchesSceneDelegate.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation

public protocol LaunchesSceneDelegate: AnyObject {
    func routeToFilters(_ current: [LaunchesFilter], completion: @escaping ([LaunchesFilter]) -> Void)
    func routeToWeb(with url: URL)
}
