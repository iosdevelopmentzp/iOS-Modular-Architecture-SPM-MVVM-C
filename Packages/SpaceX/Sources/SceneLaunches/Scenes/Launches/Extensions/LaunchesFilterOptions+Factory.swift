//
//  LaunchesFilterOptions+Factory.swift
//  
//
//  Created by Dmytro Vorko on 26.07.2022.
//

import UseCases
import Foundation

extension UseCases.LaunchesFilterOptions {
    struct Factory {
        static func make(filters: [LaunchesFilter]) -> LaunchesFilterOptions {
            var isLaunchSuccess: Bool?
            var launchDateInterval: DateInterval?
            var sorting: LaunchesFilterOptions.Sorting = .asc
            
            filters.forEach {
                switch $0 {
                case .launchYear(let yearFilter):
                    launchDateInterval = yearFilter.selectedValue.map { Self.dateInterval(year: $0) }
                    
                case .isSuccessLaunch(let filter):
                    isLaunchSuccess = filter.selectedValue
                    
                case .sorting(let sortValue):
                    sorting = sortValue == .ascending ? .asc : .desc
                }
            }
            
            return .init(
                isLaunchSuccess: isLaunchSuccess,
                launchDateInterval: launchDateInterval,
                sorting: sorting
            )
        }
    }
}

// MARK: - Private functions

private extension LaunchesFilterOptions.Factory {
    static func dateInterval(year: Int) -> DateInterval {
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar)
        dateComponents.year = year
        
        let startDate = dateComponents.date ?? Date()
        let endDate = calendar.date(byAdding: .init(month: 11, day: 31, second: -1), to: startDate) ?? Date()
        return .init(start: startDate, end: endDate)
    }
}
