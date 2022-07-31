//
//  LaunchesFilter+Extra.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import Foundation

public extension LaunchesFilter {
    static var defaultFilters: [LaunchesFilter] {
        [.launchYear(.notSelected), .isSuccessLaunch(.notSelected), .sorting(.defaultValue)]
    }
}

extension LaunchesFilter {
    func isSameType(_ comparingFilter: LaunchesFilter) -> Bool {
        switch (self, comparingFilter) {
        case (.launchYear, .launchYear), (.isSuccessLaunch, .isSuccessLaunch), (.sorting, .sorting):
            return true
        default:
            return false
        }
    }
}

extension LaunchesFilter.SortOrder {
    static var defaultValue: Self = .descending
}

extension LaunchesFilter.Filter {
    var selectedValue: T? {
        guard case .selected(let value) = self else { return nil }
        return value
    }
}

extension LaunchesFilter.Filter where T == LaunchesFilter.Year {
    var yearRangeItems: [Int] {
        let currentYear = Date().util.year()
        let selectedYear = selectedValue ?? currentYear
        
        let minRange = currentYear - 100
        let maxRange = currentYear + 100
        
        let yearRangeArray = Array(
            min(minRange, selectedYear)...max(maxRange, selectedYear)
        )
        return Array(yearRangeArray.reversed())
    }
}
