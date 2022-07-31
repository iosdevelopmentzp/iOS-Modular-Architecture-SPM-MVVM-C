//
//  Networking.swift
//  
//
//  Created by Dmytro Vorko on 22.07.2022.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityLogger

final class Networking {
    init() {
        // Should be placed in more appropriate place
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
    }
    
    func perform<R: Decodable>(target: TargetType, decoder: JSONDecoder = .api) async throws -> R {
        let task = AF.request(target, method: target.method, parameters: target.parameters, headers: target.asHTTPHeaders)
            .validate(statusCode: 200 ... 399)
            .validate(contentType: ["application/json"])
            .serializingDecodable(R.self, decoder: decoder)

        return try await task.value
    }
}
