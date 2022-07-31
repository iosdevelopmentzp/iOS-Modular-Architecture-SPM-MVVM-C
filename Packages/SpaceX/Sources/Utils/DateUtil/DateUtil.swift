//
//  DateUtil.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import Foundation

public struct DateUtil {
    // MARK: - Nested
    
    public enum DiffState {
        case future
        case today
        case past
    }
    
    // MARK: - Static
    
    static let currentCalendar = Calendar.current
    
    // MARK: - Properties
    
    let date: Date
    
    // MARK: - Public
    
    public func todayDiffState() -> DiffState {
        let calendar = Self.currentCalendar
        let startOfDate = calendar.startOfDay(for: date)
        let startOfToday = calendar.startOfDay(for: Date())
        
        if startOfDate < startOfToday {
            return .past
        } else if startOfToday > startOfToday {
            return .future
        } else {
            return .today
        }
    }
    
    public func year() -> Int {
        Self.currentCalendar.component(.year, from: self.date)
    }
}

// MARK: - Date Factory

public extension Date {
    var util: DateUtil {
        .init(date: self)
    }
}
