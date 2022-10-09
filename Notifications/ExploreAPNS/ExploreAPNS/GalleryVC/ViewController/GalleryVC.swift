//
//  ViewController.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 09/10/22.
//

import UIKit

class GalleryVC: UIViewController {
    
    private let galleryView = GalleryView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureGalleryView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        galleryView.attachments = [
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!,
            URL(string: "https://picsum.photos/300")!
        ]
    }
}
private extension GalleryVC {
    func configureGalleryView() {
        self.view.addSubview(galleryView)
        addGalleryViewConstraints()
    }
    
    func addGalleryViewConstraints() {
        galleryView.translatesAutoresizingMaskIntoConstraints = false
        galleryView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        galleryView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        galleryView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        galleryView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
}
