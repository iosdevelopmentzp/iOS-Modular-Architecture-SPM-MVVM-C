//
//  WebBrowserViewController.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import UIKit
import SafariServices
import MVVM

public class WebBrowserViewController: SFSafariViewController, View {
    // MARK: - Properties
    
    public let viewModel: WebBrowserViewModel
    private var doneTapHandler: (() -> Void)?
    
    // MARK: - Constructor
    
    public init(viewModel: WebBrowserViewModel) {
        self.viewModel = viewModel
        super.init(url: viewModel.url, configuration: .init())
    }
    
    // MARK: - Override
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupOutput()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Setup
    
    public func setupOutput() {
        let output = viewModel.bind(input: .init())
        setupInput(output)
    }
    
    public func setupInput(_ input: WebBrowserViewModel.Output) {
        doneTapHandler = {
            input.didTapDoneButton()
        }
    }
}

// MARK: - SFSafariViewControllerDelegate

extension WebBrowserViewController: SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        doneTapHandler?()
    }
}
