//
//  LaunchesSection.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import Foundation

enum LaunchesSection: Hashable {
    /// A section for displaying a single item such as loading or error UI
    case single
    
    case companyInfo
    
    case launches
    
    var title: String? {
        switch self {
        case .single:
            return nil
            
        case .companyInfo:
            return "COMPANY"
            
        case .launches:
            return "LAUNCHES"
        }
    }
}

enum LaunchesItem: Hashable {
    case loading
    case error(message: String)
    case companyInfo(description: String)
    case launch(_ launch: LaunchCellViewModel)
}
