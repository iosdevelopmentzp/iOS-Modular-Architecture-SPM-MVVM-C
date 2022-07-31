//
//  LaunchesState.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import Foundation

enum LaunchesState: Equatable {
    case idle
    case loading
    case loaded(LaunchesLoadedViewModel)
    case failed(_ error: String)
}

extension LaunchesState {
    var companyName: String? {
        guard case .loaded(let viewModel) = self else {
            return nil
        }
        return viewModel.companyName
    }
}
