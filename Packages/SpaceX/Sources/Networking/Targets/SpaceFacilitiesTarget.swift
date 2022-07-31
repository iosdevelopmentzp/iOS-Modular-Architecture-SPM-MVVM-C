//
//  SpaceFacilitiesTarget.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Alamofire

struct SpaceFacilitiesTarget: MakeableTargetType {
    // MARK: - Nested
    
    enum EndpointType {
        case rockets(parameters: [String: Any]?)
    }
    
    // MARK: - Properties
    
    let host: String
    let headers: [String: String]?
    
    var method: HTTPMethod {
        switch endpoint {
        case .rockets:
            return .post
        }
    }
    
    var path: String {
        let path: String
        
        switch endpoint {
        case .rockets:
            path = "/rockets/query"
        }
        
       return "/\(apiVersion)" + path
    }
    
    var parameters: [String : Any]? {
        switch endpoint {
        case .rockets(let parameters):
            return parameters
        }
    }
    
    private let apiVersion: String
    private let endpoint: EndpointType
    
    // MARK: - Constructor
    
    init(
        host: String,
        apiVersion: String,
        endpointType: EndpointType,
        headers: [String: String]? = nil
    ) {
        self.host = host
        self.apiVersion = apiVersion
        self.endpoint = endpointType
        self.headers = headers
    }
}
