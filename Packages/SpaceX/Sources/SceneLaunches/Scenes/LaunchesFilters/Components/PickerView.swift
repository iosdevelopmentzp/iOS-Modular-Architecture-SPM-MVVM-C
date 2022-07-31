//
//  PickerView.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import UIKit
import Extensions

protocol PickerViewDelegate: AnyObject {
    func pickerView(_ pickerView: PickerView, didTapDone sender: UIButton, selectedIndex: Int)
    func pickerView(_ pickerView: PickerView, didTapCancel sender: UIButton)
    func pickerView(_ pickerView: PickerView, didTapReset sender: UIButton)
}

final class PickerView: UIView, ViewSettableType {
    // MARK: - Properties
    
    private let contentContainer = UIView()
    private let toolsContainerView = UIView()
    private let pickerView = UIPickerView()
    private let doneButton = UIButton()
    private let cancelButton = UIButton()
    private let resetButton = UIButton()
    private var containerViewTopConstraint: NSLayoutConstraint?
    
    private var viewModel: PickerViewModel? {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    weak var delegate: PickerViewDelegate?
    
    // MARK: - Constructor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupViews() {
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.blue, for: .normal)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.gray, for: .normal)
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.red, for: .normal)
        
        [doneButton, cancelButton, resetButton].forEach {
            $0.addTarget(self, action: #selector(tapHandler(_:)), for: .touchUpInside)
        }
        
        toolsContainerView.backgroundColor = .white
        
        pickerView.backgroundColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func addViews() {
        addSubview(contentContainer)
        contentContainer.addSubview(pickerView)
        contentContainer.addSubview(toolsContainerView)
        toolsContainerView.addSubview(doneButton)
        toolsContainerView.addSubview(cancelButton)
        toolsContainerView.addSubview(resetButton)
    }
    
    func layoutViews() {
        contentContainer.snp.makeConstraints {
            containerViewTopConstraint = $0.top.equalTo(self.snp.bottom).constraint.layoutConstraints.first
            $0.left.right.equalToSuperview()
        }
        
        toolsContainerView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        pickerView.snp.makeConstraints {
            $0.top.equalTo(self.toolsContainerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(self.snp.height).multipliedBy(0.3)
        }
        
        doneButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        resetButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - User Ineraction
    
    @objc
    private func tapHandler(_ sender: UIButton) {
        switch sender {
        case doneButton:
            delegate?.pickerView(self, didTapDone: sender, selectedIndex: pickerView.selectedRow(inComponent: 0))
            
        case cancelButton:
            delegate?.pickerView(self, didTapCancel: sender)
            
        case resetButton:
            delegate?.pickerView(self, didTapReset: sender)
            
        default:
            assertionFailure("Unexpected button")
        }
    }
}

// MARK: - Configure

extension PickerView {
    func configure(using viewModel: PickerViewModel?) {
        self.viewModel = viewModel
        viewModel?.selectedIndex.map {
            pickerView.selectRow($0, inComponent: 0, animated: false)
        }
        set(isHidden: viewModel == nil, animated: true)
    }
    
    func set(isHidden: Bool, animated: Bool) {
        if !isHidden {
            self.isHidden = isHidden
        }
        
        let action = { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.black.withAlphaComponent(isHidden ? 0 : 0.7)
            self.containerViewTopConstraint?.constant = isHidden ? 0 : -self.contentContainer.bounds.height
            self.layoutIfNeeded()
        }
        
        let completion = {
            self.isHidden = isHidden
        }
        
        guard animated else {
            action()
            completion()
            return
        }
        
        UIView.animate(
            withDuration: 0.3,
            animations: action,
            completion: { _ in completion() }
        )
    }
}

// MARK: - UIPickerViewDataSource

extension PickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        (viewModel?.elements.count ?? 0) > 0 ? 1 : 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel?.elements.count ?? 0
    }
}

// MARK: - UIPickerViewDelegate

extension PickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        40
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel?.elements[safe: row]?.title
    }
}
