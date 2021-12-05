//
//  LocationManager.swift
//  ExploreCorelocation
//
//  Created by Abhilash Palem on 26/09/21.
//

import Foundation
import CoreLocation

enum LocationManagerError: Error {
    case deviceNotEligible
}

class LocationManager {
    
    static var shivaSaiFloreLoc = CLLocation(latitude: 17.365145, longitude: 78.534538)

    let locationManager: CLLocationManager
    let eventManager = LocationManagerEvents()
    init() throws {
        if CLLocationManager.significantLocationChangeMonitoringAvailable() {
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.delegate = eventManager
        } else {
            throw LocationManagerError.deviceNotEligible
        }
    }
}

class LocationManagerEvents: NSObject, CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestAlwaysAuthorization()
        case .authorizedAlways:
            print("Authorized always")
            manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            manager.startUpdatingLocation()
            manager.allowsBackgroundLocationUpdates = true
        case .authorizedWhenInUse:
            print("Authorized when in use")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Locations: \(locations)")
        print("last location: \(locations.last)")
        print("Distance between exact location and updated location: \(LocationManager.shivaSaiFloreLoc.distance(from: locations.last!))")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let errorCode = (error as? CLError)?.code {
            switch errorCode {
            case .locationUnknown:
                print("Failed with error: Location unknown Error \(error)")
            default:
                break
            }
        }
    }
}
