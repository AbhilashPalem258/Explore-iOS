//
//  GalleryItemCell.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 09/10/22.
//

import UIKit
import Combine

class GalleryItemCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let activityIndicator = UIActivityIndicatorView()
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
        configureActivityIndicatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
        super.prepareForReuse()
    }
    
    func attachment(_ url: URL) {
        activityIndicator.startAnimating()
        ImageLoader.shared.fetchImage(url: url)
            .sink {[weak self] completion in
                self?.activityIndicator.stopAnimating()
                switch completion {
                case .failure(let error):
                    print("Failed to fetch image with error: \(error)")
                default:
                    break
                }
            } receiveValue: {[weak self] data in
                self?.imageView.image = UIImage(data: data)
            }
            .store(in: &cancellables)
    }
}
private extension GalleryItemCell {
    func configureImageView() {
        self.addSubview(imageView)
        addImageViewConstraints()
    }
    
    func configureActivityIndicatorView() {
        activityIndicator.style = .medium
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
    }
    
    func addImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
