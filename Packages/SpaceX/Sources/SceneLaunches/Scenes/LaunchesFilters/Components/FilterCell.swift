//
//  FilterCell.swift
//  
//
//  Created by Dmytro Vorko on 25.07.2022.
//

import UIKit
import Extensions

final class FilterCell: UITableViewCell, ViewSettableType {
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    
    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupViews() {
        selectionStyle = .none
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        
        valueLabel.font = .systemFont(ofSize: 17)
        valueLabel.textColor = .gray
        valueLabel.numberOfLines = 0
    }
    
    func addViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
    }
    
    func layoutViews() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.top.equalToSuperview().offset(16)
            $0.right.lessThanOrEqualTo(self.valueLabel.snp.left).inset(8)
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(8)
        }
    }
}

// MARK: - Configure

extension FilterCell {
    func configure(using viewModel: FilterCellModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}


