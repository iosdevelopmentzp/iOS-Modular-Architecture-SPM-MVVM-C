//
//  View.swift
//  
//
//  Created by Dmytro Vorko on 20.07.2022.
//

import Foundation

public protocol View {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get }
    func setupOutput()
    func setupInput(_ input: ViewModelType.Output)
}
