//
//  ErrorCell.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import UIKit
import Extensions

protocol ErrorCellEventsDelegate: AnyObject {
    func cell(_ cell: ErrorCell, didPressRetryButton sender: UIButton)
}

final class ErrorCell: UITableViewCell, ViewSettableType {
    // MARK: - Properties
    
    private let stackView = UIStackView()
    private let errorImageView = UIImageView()
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let retryButton = UIButton()
    
    weak var delegate: ErrorCellEventsDelegate?
    
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
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        errorImageView.contentMode = .scaleAspectFill
        errorImageView.clipsToBounds = true
        errorImageView.image = UIImage(systemName: "exclamationmark.triangle")
        errorImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        contentStackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        contentStackView.isLayoutMarginsRelativeArrangement = true
        
        titleLabel.textColor = UIColor(named: "PrimaryText")
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.text = "Error"
        
        descriptionLabel.textColor = UIColor(named: "PrimaryText")
        descriptionLabel.font = .preferredFont(forTextStyle: .subheadline)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "An error has occurred"
        
        retryButton.addTarget(self, action: #selector(onRetryButtonTap(_:)), for: .primaryActionTriggered)
        retryButton.setTitle("Try Again", for: .normal)
        retryButton.backgroundColor = .systemGreen
        retryButton.layer.cornerRadius = 8
    }
    
    func addViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(errorImageView)
        stackView.addArrangedSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(retryButton)
        
        retryButton.snp.makeConstraints {
            $0.width.equalTo(90)
        }
    }
    
    func layoutViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - User Interaction
    
    @objc
    private func onRetryButtonTap(_ sender: UIButton) {
        delegate?.cell(self, didPressRetryButton: sender)
    }
}

// MARK: - Configure

extension ErrorCell {
    func configure(using message: String) {
        descriptionLabel.text = message
    }
}
