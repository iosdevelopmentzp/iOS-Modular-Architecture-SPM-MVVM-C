//
//  TargetType.swift
//  
//
//  Created by Dmytro Vorko on 22.07.2022.
//

import Foundation
import Alamofire

protocol TargetType: URLConvertible {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension TargetType {
    var scheme: String { "https" }
    
    var headers: [String: String]? { nil }
    
    var parameters: [String: Any]? { nil }
    
    var asHTTPHeaders: HTTPHeaders? {
        guard let headers = headers, !headers.isEmpty else { return nil }
        return .init(headers.map { HTTPHeader(name: $0.key, value: $0.value) })
    }
    
    func asURL() throws -> URL {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        
        guard let url = components.url else {
            throw TargetTypeError.invalidComponents
        }
        return url
    }
}

enum TargetTypeError: Swift.Error {
    case invalidComponents
}
