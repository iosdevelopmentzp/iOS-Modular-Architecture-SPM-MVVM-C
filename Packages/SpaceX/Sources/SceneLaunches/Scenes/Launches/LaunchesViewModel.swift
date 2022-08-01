//
//  LaunchesViewModel.swift
//  
//
//  Created by Dmytro Vorko on 20.07.2022.
//

import Foundation
import MVVM
import UseCases
import Core
import Extensions

@MainActor
public final class LaunchesViewModel: ViewModel {
    // MARK: - Nested
    
    typealias DomainData = (launches: [Launch], companyInfo: CompanyInfo)
    
    public struct Input {
        @MainThread private(set) var renderState: ArgClosure<LaunchesState>
    }
    
    public struct Output {
        enum EventType {
            case launch(_ id: String)
            case retryButton
            case filterButtonTap
        }
        
        let onEvent: ArgClosure<EventType>
    }
    
    private struct InsideEventsHandler {
        let onDidUpdateState: ArgClosure<LaunchesState>
    }
    
    // MARK: - Properties
    
    private weak var sceneDelegate: LaunchesSceneDelegate?
    
    private var task: Task<Void, Never>?
    
    private let useCase: SpaceCompanyUseCaseProtocol
    
    private var eventsHandler: InsideEventsHandler?
    
    private var state: LaunchesState = .idle {
        didSet {
            guard state != oldValue else { return }
            eventsHandler?.onDidUpdateState(state)
        }
    }
    
    private var filters: [LaunchesFilter] = LaunchesFilter.defaultFilters {
        didSet {
            guard filters != oldValue else { return }
            loadData()
        }
    }
    
    private var domainData: DomainData?
    
    // MARK: - Constructor
    
    public init(useCase: SpaceCompanyUseCaseProtocol, sceneDelegate: LaunchesSceneDelegate?) {
        self.useCase = useCase
        self.sceneDelegate = sceneDelegate
    }
    
    // MARK: - Bind
    
    public func bind(input: Input) -> Output {
        defer {
            loadData()
        }
        
        input.renderState(state)
        
        eventsHandler = InsideEventsHandler(onDidUpdateState: {
            input.renderState($0)
        })

        return .init(onEvent: { [weak self] in
            self?.handle($0)
        })
    }
}


// MARK: - Private Functions

private extension LaunchesViewModel {
    private func handle(_ event: Output.EventType) {
        switch event {
        case .launch(let launchId):
            performOpeningWebLink(for: launchId)
            
        case .retryButton:
            loadData()
            
        case .filterButtonTap:
            self.sceneDelegate?.routeToFilters(filters) { [weak self] in
                self?.filters = $0
            }
        }
    }
    
    private func performOpeningWebLink(for launchId: String) {
        guard let links = domainData?.launches.first(where: { $0.id == launchId })?.sourceLinks else {
            return
        }
        
        [links.article, links.wikipedia, links.youtubeId.map { "https://youtu.be/\($0)" }]
            .unwrap()
            .map(URL.init(string:))
            .unwrap()
            .first
            .map {
                self.sceneDelegate?.routeToWeb(with: $0)
            }
    }
    
    private func loadData() {
        task?.cancel()
        state = .loading
        
        self.task = Task {
            do {
                async let launches = try await useCase.loadLaunches(options: .Factory.make(filters: filters))
                async let companyInfo = try await useCase.loadCompanyInfo()
                let data: DomainData = try await (launches, companyInfo)
                
                guard !Task.isCancelled else { return }
                domainData = data
                state = .loaded(.Factory(data.companyInfo, data.launches).make())
            } catch {
                guard !Task.isCancelled else { return }
                state = .failed(error.localizedDescription)
            }
        }
    }
}
