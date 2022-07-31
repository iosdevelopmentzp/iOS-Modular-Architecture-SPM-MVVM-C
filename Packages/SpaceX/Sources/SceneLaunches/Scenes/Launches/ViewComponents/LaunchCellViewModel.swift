//
//  LaunchCellViewModel.swift
//  
//
//  Created by Dmytro Vorko on 22.07.2022.
//

import UIKit

struct LaunchCellViewModel: Hashable {
    let id: String
    let missionImage: String?
    let successStateImage: UIImage?
    let successStateColor: UIColor?
    let info: LaunchInfoStackViewModel
    
    var missionImageURL: URL? {
        missionImage.flatMap { URL(string: $0) }
    }
}
