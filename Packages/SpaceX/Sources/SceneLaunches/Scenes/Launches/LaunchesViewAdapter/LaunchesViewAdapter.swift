//
//  LaunchesViewAdapter.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import UIKit

final class LaunchesViewAdapter {
    // MARK: - Netsted
    
    typealias CellProvider = (UITableView, IndexPath, LaunchesItem) -> UITableViewCell?
    typealias DataSource = UITableViewDiffableDataSource<LaunchesSection, LaunchesItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<LaunchesSection, LaunchesItem>
    
    // MARK: - Properties
    
    let dataSource: DataSource
    
    private var state: LaunchesState? {
        didSet {
            guard let state = state, state != oldValue else { return }

            let snapshot = Snapshot.snapshot(from: state)
            dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
        }
    }
    
    // MARK: - Constructor
    
    init(tableView: UITableView, cellProvider: @escaping CellProvider) {
        self.dataSource = DataSource(tableView: tableView, cellProvider: cellProvider)
    }
    
    // MARK: - Update
    
    func update(with state: LaunchesState) {
        self.state = state
    }
}

private extension LaunchesViewAdapter.Snapshot {
    static func snapshot(from state: LaunchesState) -> Self {
        switch state {
        case .idle, .loading:
            return loading()
        
        case .loaded(let viewModel):
            return loaded(for: viewModel)
            
        case .failed(let message):
            return error(message)
        }
    }
    
    private static func loading() -> Self {
        var snapshot = Self()
        snapshot.appendSections([.single])
        snapshot.appendItems([.loading], toSection: .single)
        return snapshot
    }
    
    private static func error(_ message: String) -> Self {
        var snapshot = Self()
        snapshot.appendSections([.single])
        snapshot.appendItems([.error(message: message)], toSection: .single)
        return snapshot
    }
    
    private static func loaded(for viewModel: LaunchesLoadedViewModel) -> Self {
        let companyItem = ItemIdentifierType.companyInfo(description: viewModel.companyInfo)
        let launchesItems = viewModel.launches.map(ItemIdentifierType.launch)
        
        var snapshot = Self()
        snapshot.appendSections([.companyInfo, .launches])
        snapshot.appendItems([companyItem], toSection: .companyInfo)
        snapshot.appendItems(launchesItems, toSection: .launches)
        
        return snapshot
    }
}
