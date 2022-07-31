//
//  PickerViewModel.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import UIKit

struct PickerViewModel: Equatable {
    struct Element: Equatable {
        let title: String
    }
    
    let elements: [Element]
    let selectedIndex: Int?
}
