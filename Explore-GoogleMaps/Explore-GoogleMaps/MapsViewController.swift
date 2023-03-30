//
//  MapsViewController.swift
//  Explore-GoogleMaps
//
//  Created by Abhilash Palem on 03/01/23.
//

import SwiftUI
import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    private let locationmanager = CLLocationManager()
    private var mapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 48.857165, longitude: 2.354613, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: UIScreen.main.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.mapType = .hybrid
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        self.view.addSubview(mapView)
        
        configureLocationManager()
    }
    
    func configureLocationManager() {
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
}

extension MapsViewController: GMSMapViewDelegate {
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        print("tapped on my location")
        return true
    }
}

struct MapViewControllerBridge: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> MapsViewController {
    return MapsViewController()
  }

  func updateUIViewController(_ uiViewController: MapsViewController, context: Context) {
  }
}
