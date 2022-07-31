//
//  DateFormatter+Theme.swift
//  
//
//  Created by Dmytro Vorko on 23.07.2022.
//

import Foundation

public extension DateFormatter {
    static let api: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
}
