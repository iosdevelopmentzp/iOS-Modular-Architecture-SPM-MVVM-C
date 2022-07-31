//
//  LaunchesFilter.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation

public enum LaunchesFilter: Equatable {
    // MARK: - Nested
    
    public typealias Year = Int
    
    public enum Filter<T: Equatable>: Equatable {
        case selected(T)
        case notSelected
    }
    
    public enum SortOrder: Equatable, CaseIterable {
        case ascending
        case descending
    }
    
    // MARK: - Cases
    
    case launchYear(Filter<Year>)
    case isSuccessLaunch(Filter<Bool>)
    case sorting(SortOrder)
}
