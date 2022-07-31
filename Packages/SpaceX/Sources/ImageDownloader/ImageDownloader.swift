//
//  ImageDownloader.swift
//  
//
//  Created by Dmytro Vorko on 24.07.2022.
//

import Foundation
import Kingfisher
import UIKit

public protocol ImageDownloaderProtocol {
    func loadImage(url: URL, completion: ((Result<UIImage, Error>) -> Void)?)
}

public extension ImageDownloaderProtocol {
    func loadImage(url: URL) {
        loadImage(url: url, completion: nil)
    }
}

// MARK: - ImageDownloaderProtocol Implementation

struct ImageDownloader: ImageDownloaderProtocol {
    let imageView: UIImageView
    
    func loadImage(url: URL, completion: ((Result<UIImage, Error>) -> Void)?) {
        // Placeholder should be more elegantly implemented and optimized
        let isCached = ImageCache.default.isCached(forKey: url.absoluteString)
        let placeholder = isCached ? nil : ActivityIndicatorPlaceholder()
        
        imageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ],
            completionHandler: {
                switch $0 {
                case .success(let result):
                    completion?(.success(result.image))
                case .failure(let error):
                    completion?(.failure(error))
                }
            }
        )
    }
}

// MARK: - ActivityIndicatorPlaceholder

class ActivityIndicatorPlaceholder: UIActivityIndicatorView, Placeholder {
    init() {
        super.init(frame: .zero)
        self.style = .medium
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if !isAnimating {
            startAnimating()
        }
    }
}

// MARK: - Extensions

public extension UIImageView {
    var imageDownloader: ImageDownloaderProtocol {
        ImageDownloader(imageView: self)
    }
}

private extension UIImage {
    func colored(_ color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            color.setFill()
            self.draw(at: .zero)
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height), blendMode: .sourceAtop)
        }
    }

}
