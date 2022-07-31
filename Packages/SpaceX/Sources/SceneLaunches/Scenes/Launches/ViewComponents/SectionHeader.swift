//
//  SectionHeader.swift
//  
//
//  Created by Dmytro Vorko on 22.07.2022.
//

import UIKit
import Extensions

final class SectionHeader: UITableViewHeaderFooterView, ViewSettableType {
    // MARK: - Properties
    
    private let label = UILabel()
    private let topSeparator = UIView()
    private let bottomSeparator = UIView()
    
    // MARK: - Constructor
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setupViews() {
        contentView.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 1
        
        topSeparator.backgroundColor = .black
        bottomSeparator.backgroundColor = .black
    }
    
    func addViews() {
        contentView.addSubview(label)
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
    }
    
    func layoutViews() {
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(8)
        }
        
        topSeparator.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
}

// MARK: - Configure

extension SectionHeader {
    func configure(with text: String) {
        label.text = text
    }
}
