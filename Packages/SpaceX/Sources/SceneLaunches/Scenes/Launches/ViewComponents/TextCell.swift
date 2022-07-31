//
//  TextCell.swift
//  
//
//  Created by Dmytro Vorko on 21.07.2022.
//

import UIKit
import Extensions

final class TextCell: UITableViewCell, ViewSettableType {
    // MARK: - Properties
    
    private let label = UILabel()
    
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
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.numberOfLines = 0
    }
    
    func addViews() {
        contentView.addSubview(label)
    }
    
    func layoutViews() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}

// MARK: - Configure

extension TextCell {
    func configure(using text: String) {
        label.text = text
    }
}
