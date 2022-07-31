//
//  LaunchesLoadedViewModel.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import Foundation
import Core
import UIKit
import Utils

struct LaunchesLoadedViewModel: Hashable {
    let companyName: String
    let companyInfo: String
    let launches: [LaunchCellViewModel]
}

// MARK: - Factory

extension LaunchesLoadedViewModel {
    struct Factory {
        // MARK: - Properties
        
        private let companyInfo: CompanyInfo
        private let launches: [Launch]
        
        // MARK: - Constructor
        
        init(_ companyInfo: CompanyInfo, _ launches: [Launch]) {
            self.companyInfo = companyInfo
            self.launches = launches
        }
        
        // MARK: - Make
        
        func make() -> LaunchesLoadedViewModel {
            let companyDescription = """
\(companyInfo.name) was founded by \(companyInfo.founderName) in \(companyInfo.yearOfFoundation). It has now \(companyInfo.employeesCount) employees, \(companyInfo.launchSitesCount) launch sites, and is valued at USD \(companyInfo.valuation)
"""
            
            let launches = self.launches.map { launch -> LaunchCellViewModel in

                let elements: [LaunchInfoStackViewModel.Element?] = [
                    launch.missionName.flatMap {
                        LaunchInfoStackViewModel.Element(topic: "Mission", value: $0)
                    },
                    launch.formattedDate.flatMap {
                        LaunchInfoStackViewModel.Element(topic: "Date/time", value: $0)
                    },
                    launch.rocketDescription.flatMap {
                        LaunchInfoStackViewModel.Element(topic: "Rocket", value: $0)
                    },
                    launch.daysDifference.flatMap {
                        LaunchInfoStackViewModel.Element(topic: launch.dateDiffTitle, value: $0)
                    }
                ]
                
                return LaunchCellViewModel(
                    id: launch.id,
                    missionImage: launch.patchImageUrl,
                    successStateImage: launch.successImageName.flatMap {
                        UIImage(systemName: $0)?.withRenderingMode(.alwaysTemplate)
                    },
                    successStateColor: launch.successImageColor,
                    info: .init(elements: elements.unwrap())
                )
            }
            
            return .init(companyName: companyInfo.name, companyInfo: companyDescription, launches: launches)
        }
    }
}

// MARK: - Launch Extension

private extension Launch {
    var formattedDate: String? {
        date?.presentationFormatter.dateAtTime()
    }
    
    var rocketDescription: String? {
        let description = [rocket?.name, rocket?.type].unwrap().joined(separator: " / ")
        return description.isEmpty ? nil : description
    }
    
    var daysDifference: String? {
        date?.presentationFormatter.todayDayDifference()
    }
    
    var dateDiffTitle: String {
        let prefix: String
        switch date?.util.todayDiffState() {
        case .past:
            prefix = "since"
            
        default:
            prefix = "from"
        }
        return "Days \(prefix) now"
    }
    
    var successImageName: String? {
        guard let dateDiff = date?.util.todayDiffState(), dateDiff != .future, dateDiff != .today else {
            return nil
        }
        
        return isSuccess ? "checkmark" : "xmark"
    }
    
    var successImageColor: UIColor? {
        isSuccess ? UIColor.green : .red
    }
    
    var patchImageUrl: String? {
        [patchImages?.smallPatchImage, patchImages?.largePatchImage].unwrap().first
    }
}
