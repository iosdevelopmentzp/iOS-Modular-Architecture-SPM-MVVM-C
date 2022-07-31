//
//  TargetFactory.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

protocol MakeableTargetType: TargetType {
    associatedtype EndpointType
    
    init(host: String, apiVersion: String, endpointType: EndpointType, headers: [String: String]?)
}

struct TargetFactory<T: MakeableTargetType> {
    private let host: String
    private let apiVersion: String
    
    init(host: String, apiVersion: String) {
        self.host = host
        self.apiVersion = apiVersion
    }
    
    func make(endpoint: T.EndpointType, headers: [String: String]? = nil) -> TargetType {
        T.init(host: self.host, apiVersion: self.apiVersion, endpointType: endpoint, headers: headers)
    }
}
