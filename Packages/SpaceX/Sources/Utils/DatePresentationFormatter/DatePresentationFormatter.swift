//
//  DatePresentationFormatter.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import Foundation

public struct DatePresentationFormatter {
    // MARK: - Static
    
    private static let calendar = Calendar.current
    
    private static let dateAtTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.locale = .current
        formatter.dateFormat = "d' 'MMM' 'yyy' at 'h:mm' 'a"
        return formatter
    }()
    
    private static let withoutTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.locale = .current
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
    
    // MARK: - Properties
    
    fileprivate let date: Date
    
    // MARK: - Public
    
    public func withoutTime() -> String {
        Self.withoutTimeFormatter.string(from: date)
    }
    
    public func dateAtTime() -> String {
        Self.dateAtTimeFormatter.string(from: date)
    }
    
    public func todayDayDifference() -> String? {
        let calendar = Self.calendar
        let date = calendar.startOfDay(for: self.date)
        let todayDate = calendar.startOfDay(for: Date())
        
        let component = calendar.dateComponents([.day], from: todayDate, to: date)
        var sign = ""
        if todayDate != date {
            sign = todayDate > date ? "-" : "+"
        }
        return component.day.map { "\(sign)\(abs($0))" }
    }
}

// MARK: - Date Formatter getter

public extension Date {
    var presentationFormatter: DatePresentationFormatter {
        .init(date: self)
    }
}
