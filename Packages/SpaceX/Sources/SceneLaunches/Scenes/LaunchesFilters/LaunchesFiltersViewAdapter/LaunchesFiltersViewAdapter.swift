//
//  LaunchesFiltersViewAdapter.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import UIKit

class LaunchesFiltersViewAdapter {
    // MARK: - Netsted
    
    typealias CellProvider = (UITableView, IndexPath, LaunchesFiltersItem) -> UITableViewCell?
    typealias DataSource = UITableViewDiffableDataSource<LaunchesFiltersSection, LaunchesFiltersItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<LaunchesFiltersSection, LaunchesFiltersItem>
    
    // MARK: - Properties
    
    let dataSource: DataSource
    
    private var state: LaunchesFiltersState? {
        didSet {
            guard
                let state = state,
                state != oldValue,
                let snapshot = Snapshot.snapshot(from: state, oldValue: oldValue) else {
                return
            }

            dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
        }
    }
    
    // MARK: - Constructor
    
    init(tableView: UITableView, cellProvider: @escaping CellProvider) {
        self.dataSource = DataSource(tableView: tableView, cellProvider: cellProvider)
    }
    
    // MARK: - Update
    
    func update(with state: LaunchesFiltersState) {
        self.state = state
    }
}

private extension LaunchesFiltersViewAdapter.Snapshot {
    static func snapshot(from state: LaunchesFiltersState, oldValue: LaunchesFiltersState?) -> Self? {
        switch state {
        case .idle:
            return idle()
            
        case .filters(let items), .picker(let items, _):
            if let oldValue = oldValue, oldValue.filtersModels == items {
                return nil
            }
            return filters(items: items)
        }
    }
    
    private static func idle() -> Self {
        Self()
    }
    
    private static func filters(items: [FilterCellModel]) -> Self {
        var snapshot = Self()
        snapshot.appendSections([.main])
        snapshot.appendItems(items.map { .filter($0) }, toSection: .main)
        return snapshot
    }
}
