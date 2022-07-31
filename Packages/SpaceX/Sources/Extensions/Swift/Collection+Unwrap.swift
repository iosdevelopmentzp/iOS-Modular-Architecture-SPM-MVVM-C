//
//  Collection+Unwrap.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public extension Collection {
    func unwrap<T>() -> [T] where Element == Optional<T> {
        compactMap { $0 }
    }
}
