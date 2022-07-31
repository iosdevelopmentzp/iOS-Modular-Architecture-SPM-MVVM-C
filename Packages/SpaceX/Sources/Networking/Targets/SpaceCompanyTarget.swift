//
//  SpaceCompanyTarget.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Alamofire

struct SpaceCompanyTarget: MakeableTargetType {
    // MARK: - Nested
    
    enum EndpointType {
        case companyInfo
        case launches(parameters: [String: Any]?)
    }
    
    // MARK: - Properties
    
    let host: String
    let headers: [String: String]?
    
    var method: HTTPMethod {
        switch self.endpoint {
        case .companyInfo:
            return .get
        case .launches:
            return .post
        }
    }
    
    var path: String {
        let path: String
        
        switch endpoint {
        case .companyInfo:
            path = "/company"
        case .launches:
            path = "/launches/query"
        }
        
        return "/\(apiVersion)" + path
    }
    
    var parameters: [String : Any]? {
        switch endpoint {
        case .companyInfo:
            return nil
            
        case .launches(let parameters):
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
