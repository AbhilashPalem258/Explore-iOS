//
//  ViewController.swift
//  ExploreCollectionView
//
//  Created by Abhilash Palem on 27/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var contentCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 8, left: 16, bottom: 8, right: 16)
        layout.minimumInteritemSpacing = 8
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .systemBrown
        collection.register(PhotoGridCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotoGridCollectionViewCell.self))
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed
        initialConfiguration()
    }

}
extension ViewController {
    private func initialConfiguration() {
        self.view.addSubview(contentCollection)
//        contentCollection.frame = view.bounds
        
        contentCollection.translatesAutoresizingMaskIntoConstraints = false
        contentCollection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoGridCollectionViewCell.self), for: indexPath) as? PhotoGridCollectionViewCell
        cell?.backgroundColor = .darkGray
        return cell ?? UICollectionViewCell()
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 2*16 - 3*8)/3
        return CGSize(width: width, height: 100)
    }
}
