//
//  ViewModel.swift
//  
//
//  Created by Dmytro Vorko on 20.07.2022.
//

import Foundation

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    @MainActor func bind(input: Input) -> Output
}
