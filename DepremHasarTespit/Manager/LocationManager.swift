//
//  LocationManager.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 15.06.2023.
//

//import CoreLocation
//import MapKit
//import Foundation
//
//class LocationManager: NSObject, CLLocationManagerDelegate {
//    
//    let mapView = MKMapView()
//    static let shared = LocationManager()
//    
//    let locationManager = CLLocationManager()
//    
//    var completion: ((CLLocation) -> Void)?
//    
//    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest // BATTERY
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.distanceFilter = kCLDistanceFilterNone
//        mapView.showsUserLocation = true
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        manager.stopUpdatingLocation()
//        render(location)
//    }
//    
//    func render(_ location: CLLocation) {
//        
//        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        
//        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
//        
//        mapView.setRegion(region, animated: true)
//        
//    }
//}
