//
//  LaunchInfoStackView.swift
//  
//
//  Created by Dmytro Vorko on 21.07.2022.
//

import UIKit
import Extensions

final class LaunchInfoStackView: UIStackView, ViewSettableType {
    // MARK: - Constructor

    override init(frame: CGRect) {
        super.init(frame: frame)
        performSetupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupViews() {
        axis = .vertical
    }
}

// MARK: - Configure

extension LaunchInfoStackView {
    func configure(using viewModel: LaunchInfoStackViewModel) {
        arrangedSubviews.forEach { $0.isHidden = true }
        
        viewModel.elements.enumerated().forEach {
            let elementView = (arrangedSubviews[safe: $0.offset] as? ElementView) ?? {
                let elementView = ElementView()
                addArrangedSubview(elementView)
                return elementView
            }()
            elementView.isHidden = false
            elementView.configure(using: $0.element)
        }
    }
}

// MARK: - ElementView

private final class ElementView: UIView, ViewSettableType {
    // MARK: - Properties
    
    private let topicLabel = UILabel()
    private let valueLabel = UILabel()
    
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
        topicLabel.textColor = .black
        topicLabel.font = .systemFont(ofSize: 14, weight: .bold)
        topicLabel.numberOfLines = 1
        
        valueLabel.textColor = .gray
        valueLabel.font = .systemFont(ofSize: 14)
        valueLabel.numberOfLines = 1
    }
    
    func addViews() {
        addSubview(topicLabel)
        addSubview(valueLabel)
    }
    
    func layoutViews() {
        topicLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(8)
            $0.width.equalTo(self.snp.width).multipliedBy(0.35)
        }
        
        valueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(self.topicLabel.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(30)
        }
    }
}

private extension ElementView {
    func configure(using model: LaunchInfoStackViewModel.Element) {
        topicLabel.text = model.topic
        valueLabel.text = model.value
    }
}
