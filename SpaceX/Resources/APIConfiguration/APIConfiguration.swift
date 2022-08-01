//
//  APIConfiguration.swift
//  SpaceX
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation
import Networking

struct APIConfiguration: PlistDecodableType, NetworkApiConfigurationProtocol {
    let host: String
    let apiVersion: String
}
