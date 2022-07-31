//
//  NetworkApiConfigurationProtocol.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public protocol NetworkApiConfigurationProtocol {
    var host: String { get }
    var apiVersion: String { get }
}
