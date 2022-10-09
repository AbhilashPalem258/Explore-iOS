//
//  GallerySwiftUIView.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 09/10/22.
//

import UIKit
import SwiftUI

struct GallerySwiftUIView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let galleryVC = GalleryVC()
        return galleryVC
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
