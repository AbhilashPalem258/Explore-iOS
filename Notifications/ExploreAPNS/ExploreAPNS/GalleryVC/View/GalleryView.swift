//
//  GalleryView.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 09/10/22.
//

import UIKit
import SwiftUI

class GalleryView: UIView {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8.0
        layout.minimumLineSpacing = 16.0
        layout.sectionInset = .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        layout.estimatedItemSize = CGSize(width: 70, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryItemCell.self, forCellWithReuseIdentifier: String(describing: GalleryItemCell.self))
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var attachments: [URL]? {
        didSet {
            collectionView.reloadData()
        }
    }

}
private extension GalleryView {
    func configureCollectionView() {
        collectionView.dataSource = self
        self.addSubview(collectionView)
        addCollectionViewConstraints()
    }
    
    func addCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
extension GalleryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.attachments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GalleryItemCell.self), for: indexPath) as? GalleryItemCell
        if let attachment = attachments?[indexPath.row] {
            cell?.attachment(attachment)
        }
        return cell ?? UICollectionViewCell()
    }
}
