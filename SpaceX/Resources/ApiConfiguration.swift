//
//  ApiConfiguration.swift
//  SpaceX
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation
import Networking

struct ApiConfiguration: NetworkApiConfigurationProtocol {
    var host: String {
        "api.spacexdata.com"
    }
    
    var apiVersion: String {
        "v4"
    }
}
