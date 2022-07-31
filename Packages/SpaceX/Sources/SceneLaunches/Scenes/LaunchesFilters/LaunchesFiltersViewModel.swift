//
//  LaunchesFiltersViewModel.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import Foundation
import MVVM
import Extensions

@MainActor
public final class LaunchesFiltersViewModel: ViewModel {
    // MARK: - Nested
    
    typealias PickerItemIndex = Int
    
    public struct Input {
        @MainThread private(set) var renderState: ArgClosure<LaunchesFiltersState>
    }
    
    public struct Output {
        enum EventType {
            case pickerDoneTap(selectedIndex: Int)
            case pickerCancelTap
            case pickerResetTap
            case filterTap(index: Int)
            case cancelTap
            case confirmTap
        }
        
        let onEvent: ArgClosure<EventType>
    }
    
    private struct InsideEventsHandler {
        let onNewState: ArgClosure<LaunchesFiltersState>
        /// Nil argument means that user taped reset
        ///
        var onPickerChose: ArgClosure<PickerItemIndex?>?
    }
    
    // MARK: - Properties
    
    private var eventsHandler: InsideEventsHandler?
    
    private var filters: [LaunchesFilter]
    
    private var state: LaunchesFiltersState = .idle {
        didSet {
            guard state != oldValue else { return }
            eventsHandler?.onNewState(state)
        }
    }
    
    // MARK: - Constructor
    
    public init(filters: [LaunchesFilter], sceneDelegate: LaunchesFiltersSceneDelegate?) {
        self.filters = filters
        self.sceneDelegate = sceneDelegate
    }
    
    // MARK: - Properties
    
    private weak var sceneDelegate: LaunchesFiltersSceneDelegate?
    
    // MARK: - Bind
    
    public func bind(input: Input) async -> Output {
        defer {
            setupFiltersState()
        }
        
        input.renderState(state)
        
        eventsHandler = .init(
            onNewState: input.renderState,
            onPickerChose: nil
        )
        
        return .init(onEvent: { [weak self] in self?.handle($0) })
    }
}

// MARK: - Private

private extension LaunchesFiltersViewModel {
    private func handle(_ event: Output.EventType) {
        switch event {
        case .pickerDoneTap(let selectedIndex):
            eventsHandler?.onPickerChose?(selectedIndex)
            eventsHandler?.onPickerChose = nil
            setupFiltersState()
            
        case .pickerCancelTap:
            eventsHandler?.onPickerChose = nil
            setupFiltersState()
            
        case .pickerResetTap:
            eventsHandler?.onPickerChose?(nil)
            eventsHandler?.onPickerChose = nil
            setupFiltersState()
            
        case .filterTap(let index):
            filters[safe: index].map {
                setupPickerState(selectedFilter: $0)
            }
            
        case .cancelTap:
            sceneDelegate?.dismissScene()
            
        case .confirmTap:
            sceneDelegate?.didTapConfirm(with: filters)
        }
    }
    
    private func setupFiltersState() {
        state = .filters(
            filters.map(FilterCellModel.Factory.make(_:))
        )
    }
    
    private func setupPickerState(selectedFilter: LaunchesFilter) {
        let filterViewModels = filters.map(FilterCellModel.Factory.make(_:))
        setupPickerState(filters: filterViewModels, selectedFilter: selectedFilter)
    }
}

// MARK: - Setup Picker Data

/// The best way implement the separate view module with picker view. Rout to this module may do Coordinator.
/// But this more faster decision.
private extension LaunchesFiltersViewModel {
    private typealias SetupPickerArguments = (
        filter: LaunchesFilter,
        selectedIndex: Int?,
        titles: [String],
        onChosenIndex: (Int) -> (LaunchesFilter),
        defaultValue: LaunchesFilter
    )
    
    private func setupPickerState(filters: [FilterCellModel], selectedFilter: LaunchesFilter) {
        let arguments: (
            filter: LaunchesFilter,
            selectedIndex: Int?,
            titles: [String],
            onChosenIndex: (Int) -> (LaunchesFilter),
            defaultValue: LaunchesFilter
        )
        
        switch selectedFilter {
        case .launchYear(let filterValue):
            let yearRangeArray = filterValue.yearRangeItems
            let selectedIndex = yearRangeArray.firstIndex(
                of: filterValue.selectedValue ?? Date().util.year()
            )
            
            arguments = (
                filter: selectedFilter,
                selectedIndex: selectedIndex,
                titles: yearRangeArray.map(String.init),
                onChosenIndex: {
                    guard let year = yearRangeArray[safe: $0] else {
                        return .launchYear(.notSelected)
                    }
                    return .launchYear(.selected(year))
                },
                defaultValue: .launchYear(.notSelected)
            )
            
        case .isSuccessLaunch(let filter):
            let values = [true, false]
            let selectedIndex = filter.selectedValue.flatMap {
                values.firstIndex(of: $0)
            } ?? 0
            
            arguments = (
                filter: selectedFilter,
                selectedIndex: selectedIndex,
                titles: values.map { $0 ? "Yes" : "No" },
                onChosenIndex: {
                    let newValue = values[safe: $0] ?? false
                    return .isSuccessLaunch(.selected(newValue))
                },
                defaultValue: .isSuccessLaunch(.notSelected)
            )
            
        case .sorting(let sorting):
            let values = LaunchesFilter.SortOrder.allCases
            let selectedIndex = values.firstIndex(of: sorting)
            
            arguments = (
                filter: selectedFilter,
                selectedIndex: selectedIndex,
                titles: values.map(\.localizedTitle) ,
                onChosenIndex: {
                    let newValue = values[safe: $0] ?? .defaultValue
                    return .sorting(newValue)
                },
                defaultValue: .sorting(.defaultValue)
            )
        }
        
        let pickerViewModel = setupPickerViewModel(arguments)
        
        state = .picker(filters, pickerViewModel)
    }
    
    private func setupPickerViewModel(_ arguments: SetupPickerArguments) -> PickerViewModel {
        let elements = arguments.titles.map(PickerViewModel.Element.init(title:))
        
        eventsHandler?.onPickerChose = { [weak self] chosenIndex in
            guard let self = self else { return }
            self.filters = self.filters.map {
                // Find the same type filter
                guard arguments.filter.isSameType($0) else { return $0 }
                
                // If chosenIndex is nil, it means that user taped reset
                guard let chosenIndex = chosenIndex else { return arguments.defaultValue }
                
                return arguments.onChosenIndex(chosenIndex)
            }
        }
        
        return .init(elements: elements, selectedIndex: arguments.selectedIndex)
    }
}
