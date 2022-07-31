//
//  JSONDecoder+Theme.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation
import Extensions

extension JSONDecoder {
    static let api: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.api)
        return decoder
    }()
}
