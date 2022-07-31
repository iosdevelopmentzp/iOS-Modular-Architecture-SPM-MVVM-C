//
//  LaunchesFiltersViewController.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import UIKit
import MVVM
import Extensions

public final class LaunchesFiltersViewController: UIViewController, View, ViewSettableType {
    // MARK: - Nested
    
    private struct InsideEventsHandler {
        let onPickerDoneTap: ArgClosure<Int>
        let onPickerCancelTap: Closure
        let onPickerResetTap: Closure
        let onFilterTap: ArgClosure<Int>
        let cancelButtonTap: Closure
        let confirmButtonTap: Closure
    }
    
    // MARK: - Properties
    
    private let picker = PickerView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let confirmButton = UIButton()
    private let cancelButton = UIButton()
    private lazy var adapter: LaunchesFiltersViewAdapter = initializeAdapter()
    
    public let viewModel: LaunchesFiltersViewModel
    private var eventsHandler: InsideEventsHandler?
    
    // MARK: - Constructor
    
    public init(viewModel: LaunchesFiltersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        performSetupViews()
        setupOutput()
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        self.view.backgroundColor = .white
        
        tableView.dataSource = adapter.dataSource
        tableView.delegate = self
        tableView.register(FilterCell.self, forCellReuseIdentifier: String(describing: FilterCell.self))
        tableView.rowHeight = UITableView.automaticDimension
        
        picker.delegate = self
        picker.set(isHidden: true, animated: false)
        
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .blue
        confirmButton.layer.cornerRadius = 8
        confirmButton.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.red.cgColor
        cancelButton.addTarget(self, action: #selector(onButtonTap(_:)), for: .touchUpInside)
    }
    
    public func addViews() {
        view.addSubview(tableView)
        view.addSubview(cancelButton)
        view.addSubview(confirmButton)
        view.addSubview(picker)
    }
    
    public func layoutViews() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        picker.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        confirmButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(30)
            $0.left.equalTo(self.view.snp.centerX).offset(16)
            $0.height.equalTo(44)
        }
        
        cancelButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(30)
            $0.right.equalTo(self.view.snp.centerX).inset(16)
            $0.height.equalTo(44)
        }
    }
    
    public func setupOutput() {
        let output = type(of: self.viewModel).Input(renderState: .init({ [weak self] in
            self?.render(state: $0)
        }))
        
        Task {
            let input = await viewModel.bind(input: output)
            setupInput(input)
        }
    }
    
    public func setupInput(_ input: LaunchesFiltersViewModel.Output) {
        eventsHandler = .init(
            onPickerDoneTap: {
                input.onEvent(.pickerDoneTap(selectedIndex: $0))
            },
            onPickerCancelTap: {
                input.onEvent(.pickerCancelTap)
            },
            onPickerResetTap: {
                input.onEvent(.pickerResetTap)
            },
            onFilterTap: {
                input.onEvent(.filterTap(index: $0))
            },
            cancelButtonTap: {
                input.onEvent(.cancelTap)
            },
            confirmButtonTap: {
                input.onEvent(.confirmTap)
            }
        )
    }
    
    // MARK: - User Interaction
    
    @objc
    private func onButtonTap(_ sender: UIButton) {
        switch sender {
        case cancelButton:
            eventsHandler?.cancelButtonTap()
            
        case confirmButton:
            eventsHandler?.confirmButtonTap()
            
        default:
            assertionFailure("Unexpected button")
        }
    }
}

// MARK: - Private Functions

private extension LaunchesFiltersViewController {
    private func render(state: LaunchesFiltersState) {
        picker.configure(using: state.pickerViewModel)
        adapter.update(with: state)
    }
    
    private func initializeAdapter() -> LaunchesFiltersViewAdapter {
        .init(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .filter(let viewModel):
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterCell.self), for: indexPath) as! FilterCell
                cell.configure(using: viewModel)
                return cell
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension LaunchesFiltersViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventsHandler?.onFilterTap(indexPath.row)
    }
}

// MARK: - PickerViewDelegate

extension LaunchesFiltersViewController: PickerViewDelegate {
    func pickerView(_ pickerView: PickerView, didTapDone sender: UIButton, selectedIndex: Int) {
        eventsHandler?.onPickerDoneTap(selectedIndex)
    }
    
    func pickerView(_ pickerView: PickerView, didTapCancel sender: UIButton) {
        eventsHandler?.onPickerCancelTap()
    }
    
    func pickerView(_ pickerView: PickerView, didTapReset sender: UIButton) {
        eventsHandler?.onPickerResetTap()
    }
}
