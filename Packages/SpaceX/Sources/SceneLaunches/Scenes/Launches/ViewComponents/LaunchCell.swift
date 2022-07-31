//
//  File.swift
//  
//
//  Created by Dmytro Vorko on 21.07.2022.
//

import UIKit
import Extensions
import ImageDownloader

final class LaunchCell: UITableViewCell, ViewSettableType {
    // MARK: - Properties
    
    private let contentContainer = UIView()
    private let missionImageView = UIImageView()
    private let launchStatusImageView = UIImageView()
    private let infoStackView = LaunchInfoStackView()
    private let bottomSeparator = UIView()
    
    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        performSetupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override func prepareForReuse() {
        super.prepareForReuse()
        missionImageView.image = nil
    }
    
    // MARK: - Setup
    
    func setupViews() {
        selectionStyle = .none
        missionImageView.contentMode = .scaleAspectFit
        launchStatusImageView.contentMode = .scaleAspectFit
        
        bottomSeparator.backgroundColor = .black
    }
    
    func addViews() {
        contentView.addSubview(contentContainer)
        [missionImageView, launchStatusImageView, infoStackView].forEach {
            contentContainer.addSubview($0)
        }
        
        contentView.addSubview(bottomSeparator)
    }
    
    func layoutViews() {
        contentContainer.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        missionImageView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        launchStatusImageView.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.size.equalTo(25)
        }
        
        infoStackView.snp.makeConstraints {
            $0.left.equalTo(missionImageView.snp.right)
            $0.top.bottom.equalToSuperview()
            $0.right.equalTo(launchStatusImageView.snp.left)
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.bottom.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
}

extension LaunchCell {
    func configure(using viewModel: LaunchCellViewModel) {
        viewModel.missionImageURL.map(missionImageView.imageDownloader.loadImage(url:))
        
        launchStatusImageView.image = viewModel.successStateImage
        launchStatusImageView.tintColor = viewModel.successStateColor
        infoStackView.configure(using: viewModel.info)
    }
}
