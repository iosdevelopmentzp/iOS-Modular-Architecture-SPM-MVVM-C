//
//  LaunchInfoStackViewModel.swift
//  
//
//  Created by Dmytro Vorko on 22.07.2022.
//

import Foundation

struct LaunchInfoStackViewModel: Hashable {
    struct Element: Hashable {
        let topic: String
        let value: String
    }
    
    let elements: [Element]
}
