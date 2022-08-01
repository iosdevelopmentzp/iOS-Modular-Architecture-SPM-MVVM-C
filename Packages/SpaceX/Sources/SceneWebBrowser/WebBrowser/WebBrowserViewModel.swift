//
//  WebBrowserViewModel.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation
import MVVM
import UIKit

public final class WebBrowserViewModel: ViewModel {
    // MARK: - Nested
    
    public struct Input {}
    
    public struct Output {
        let didTapDoneButton: () -> ()
    }
    
    // MARK: - Properties
    
    public weak var sceneDelegate: WebBrowserSceneDelegate?
    
    let url: URL
    
    // MARK: - Constructor
    
    public init(url: URL) {
        self.url = url
    }
    
    // MARK: - Bind
    
    public func bind(input: Input) -> Output {
        .init(didTapDoneButton: { [weak self] in
            self?.sceneDelegate?.didTapDoneButton()
        })
    }
}
