//
//  LaunchesViewController.swift
//
//
//  Created by Dmytro Vorko on 20.07.2022.
//

import UIKit
import MVVM
import SnapKit
import Extensions

public final class LaunchesViewController: UIViewController, View, ViewSettableType {
    // MARK: - Nested
    
    private struct InsideEventsHandler {
        let onDidTapLaunch: (String) -> Void
        let onDidTapRetryButton: () -> Void
        let onDidTapFilterButton: () -> Void
    }
    
    // MARK: - Properties
    
    public let viewModel: LaunchesViewModel
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let filterButton = UIButton()
    
    private lazy var adapter = initializeAdapter()
    private var eventsHandler: InsideEventsHandler?
    
    // MARK: - Constructor
    
    public init(viewModel: LaunchesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        performSetupViews()
        setupOutput()
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        // TODO: - Change with app resources
        view.backgroundColor = .white
        
        tableView.dataSource = adapter.dataSource
        tableView.delegate = self
        
        tableView.register(TextCell.self, forCellReuseIdentifier: String(describing: TextCell.self))
        tableView.register(LaunchCell.self, forCellReuseIdentifier: String(describing: LaunchCell.self))
        tableView.register(ErrorCell.self, forCellReuseIdentifier: String(describing: ErrorCell.self))
        tableView.register(LoadingCell.self, forCellReuseIdentifier: String(describing: LoadingCell.self))
        
        tableView.register(SectionHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: SectionHeader.self))
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = 1
        tableView.separatorStyle = .none
        
        let filteImage = UIImage(named: "filter", in: Bundle.module, compatibleWith: nil)?
            .withRenderingMode(.alwaysTemplate)
        filterButton.setImage(filteImage, for: .normal)
        filterButton.tintColor = .gray
        filterButton.addTarget(self, action: #selector(onFilterButtonTap(_:)), for: .primaryActionTriggered)
    }

    public func addViews() {
        view.addSubview(tableView)
        
        let filterItem = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem = filterItem
    }
    
    public func layoutViews() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        filterButton.snp.makeConstraints {
            $0.size.equalTo(24)
        }
    }
    
    public func setupOutput() {
        let output = type(of: self.viewModel).Input.init(
            renderState: .init({ [weak self] in
                self?.render(state: $0)
            })
        )
        
        let input = viewModel.bind(input: output)
        setupInput(input)
    }
    
    public func setupInput(_ input: LaunchesViewModel.Output) {
        eventsHandler = .init(
            onDidTapLaunch: {
                input.onEvent(.launch($0))
            },
            onDidTapRetryButton: {
                input.onEvent(.retryButton)
            },
            onDidTapFilterButton: {
                input.onEvent(.filterButtonTap)
            }
        )
    }
    
    // MARK: - User Interaction
    
    @objc
    private func onFilterButtonTap(_ sender: UIButton) {
        eventsHandler?.onDidTapFilterButton()
    }
}

// MARK: - Private Functions

private extension LaunchesViewController {
    private func render(state: LaunchesState) {
        if let companyName = state.companyName, companyName != title {
            title = companyName
        }
        adapter.update(with: state)
    }
    
    private func initializeAdapter() -> LaunchesViewAdapter {
        .init(tableView: tableView) { [weak self] tableView, indexPath, item in
            // TODO: - Get rid of force unwrap
            switch item {
            case .loading:
                let loadingCell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: LoadingCell.self),
                    for: indexPath
                )
                return loadingCell
                
            case .error(let message):
                let errorCell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: ErrorCell.self),
                    for: indexPath
                ) as! ErrorCell
                errorCell.delegate = self
                errorCell.configure(using: message)
                return errorCell
                
            case .companyInfo(let description):
                let textCell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: TextCell.self),
                    for: indexPath
                ) as! TextCell
                textCell.configure(using: description)
                return textCell
                
            case .launch(let viewModel):
                let launchCell = tableView.dequeueReusableCell(
                    withIdentifier: String(describing: LaunchCell.self),
                    for: indexPath
                ) as! LaunchCell
                launchCell.configure(using: viewModel)
                return launchCell
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension LaunchesViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = adapter.dataSource.section(by: section)?.title else {
            return nil
        }
        
        // TODO: - Get rid of force unwrap
        let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: SectionHeader.self)) as! SectionHeader
        sectionView.configure(with: title)
        return sectionView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        adapter.dataSource.section(by: section)?.title == nil ? 0 : 40
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        adapter.dataSource.item(by: indexPath).map {
            switch $0 {
            case .loading, .error, .companyInfo:
                break
            case .launch(let item):
                eventsHandler?.onDidTapLaunch(item.id)
            }
        }
    }
}
 
// MARK: - ErrorCellEventsDelegate

extension LaunchesViewController: ErrorCellEventsDelegate {
    func cell(_ cell: ErrorCell, didPressRetryButton sender: UIButton) {
        eventsHandler?.onDidTapRetryButton()
    }
}
