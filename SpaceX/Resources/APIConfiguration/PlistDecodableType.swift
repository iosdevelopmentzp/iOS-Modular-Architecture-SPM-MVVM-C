//
//  PlistDecodableType.swift
//  SpaceX
//
//  Created by Dmytro Vorko on 01.08.2022.
//

import Foundation

protocol PlistDecodableType: Decodable {
    static var plistFileName: String { get }
}

extension PlistDecodableType {
    static var plistFileName: String {
        String(describing: self)
    }
    
    static func decoded() -> Self {
        do {
            return try PlistDecoder().decode()
        } catch {
            fatalError("Failed attempt decode plist. Type: \(Self.self). Error: \(error)")
        }
    }
}
