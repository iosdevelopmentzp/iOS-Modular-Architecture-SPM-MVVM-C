//
//  LaunchesFiltersState.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation

enum LaunchesFiltersState: Equatable {
    case idle
    case filters([FilterCellModel])
    case picker([FilterCellModel], PickerViewModel)
}

extension LaunchesFiltersState {
    var pickerViewModel: PickerViewModel? {
        guard case .picker(_, let viewModel) = self else {
            return nil
        }
        return viewModel
    }
    
    var filtersModels: [FilterCellModel]? {
        guard case .picker(let viewModels, _) = self else {
            return nil
        }
        return viewModels
    }
}
