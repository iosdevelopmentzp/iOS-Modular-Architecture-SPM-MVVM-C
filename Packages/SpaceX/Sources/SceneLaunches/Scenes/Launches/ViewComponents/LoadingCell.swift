//
//  LoadingCell.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import UIKit
import Extensions

final class LoadingCell: UITableViewCell, ViewSettableType {
    // MARK: - Properties
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
    }
    
    // MARK: - Setup
    
    func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
    }
    
    func addViews() {
        contentView.addSubview(activityIndicator)
    }
    
    func layoutViews() {
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(50)
        }
    }
}
