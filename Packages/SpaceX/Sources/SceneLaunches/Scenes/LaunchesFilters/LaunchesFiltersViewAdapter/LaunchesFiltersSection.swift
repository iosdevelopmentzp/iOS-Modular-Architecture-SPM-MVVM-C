//
//  File.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation

enum LaunchesFiltersSection: Hashable {
    case main
}

enum LaunchesFiltersItem : Hashable {
    case filter(FilterCellModel)
}
