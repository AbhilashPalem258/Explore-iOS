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
        sendDataToView()
    }
}
private extension GalleryVC {
    func configureGalleryView() {
        galleryView.delegate = self
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
    
    func sendDataToView() {
        galleryView.attachments = [
            URL(string: "https://file-examples.com/storage/fe6081327b634aed29d0972/2017/10/file_example_JPG_100kB.jpg")!,
            URL(string: "https://loremflickr.com/cache/resized/65535_49200634857_7afb2aac99_320_240_g.jpg")!,
            URL(string: "https://loremflickr.com/cache/resized/65535_51130409890_2035556434_320_240_nofilter.jpg")!,
            URL(string: "https://loremflickr.com/cache/resized/65535_49481733073_dd47920670_320_240_nofilter.jpg")!,
            URL(string: "https://loremflickr.com/cache/resized/65535_52139346638_9a4ccb9849_320_240_nofilter.jpg")!,
            URL(string: "https://www.w3schools.com/images/w3schools_green.jpg")!,
            URL(string: "https://res.cloudinary.com/demo/image/upload/c_scale,w_200/lady.jpg")!,
            URL(string: "https://res.cloudinary.com/demo/image/upload/sample.jpg")!,
            URL(string: "https://res.cloudinary.com/demo/image/upload/ar_1.0,c_thumb,g_face,w_0.6,z_0.7/r_max/co_brown,e_outline/co_grey,e_shadow,x_30,y_55/actor.png")!
        ]
    }
}
extension GalleryVC: GalleryViewDelegate {
    func refreshClicked() {
        sendDataToView()
    }
}
