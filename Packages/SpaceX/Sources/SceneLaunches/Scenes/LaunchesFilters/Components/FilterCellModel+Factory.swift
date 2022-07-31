//
//  File.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation

extension FilterCellModel {
    struct Factory {
        static func make(_ filter: LaunchesFilter) -> FilterCellModel {
            switch filter {
            case .launchYear(let filter):
                return Self.cellModel(forLaunchInterval: filter)
                
            case .isSuccessLaunch(let filter):
                return Self.cellModel(isSuccessfulLaunch: filter)
                
            case .sorting(let sortOrder):
                return Self.cellModel(sorting: sortOrder)
            }
        }
    }
}

// MARK: - Private Functions

private extension FilterCellModel.Factory {
    private static let notSelectedValue = "Not Selected"
    
    private static func cellModel(sorting filter: LaunchesFilter.SortOrder) -> FilterCellModel {
        let title = "Sort Order"
        let value = filter.localizedTitle
        
        return .init(title: title, value: value)
    }
    
    private static func cellModel(isSuccessfulLaunch filter: LaunchesFilter.Filter<Bool>) -> FilterCellModel {
        let title = "Launch was successful"
        let value: String
        
        switch filter {
            
        case .selected(let isSuccessful):
            value = isSuccessful ? "Yes" : "No"
            
        case .notSelected:
            value = Self.notSelectedValue
        }
        
        return .init(title: title, value: value)
    }
    
    private static func cellModel(forLaunchInterval filter: LaunchesFilter.Filter<Int>) -> FilterCellModel {
        let title = "Launch Year"
        let value: String
        
        switch filter {
        case .selected(let year):
            value = String(year)
            
        case .notSelected:
            value = Self.notSelectedValue
        }
        
        return .init(title: title, value: value)
    }
}

// MARK: - LaunchesFilter.SortOrder Extension

extension LaunchesFilter.SortOrder {
    var localizedTitle: String {
        switch self {
        case .ascending:
            return "Ascending"
            
        case .descending:
            return "Descending"
        }
    }
}
