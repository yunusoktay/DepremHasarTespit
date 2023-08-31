//
//  MapViewController.swift
//  DepremHasarTespit
//
//  Created by yunus oktay on 13.06.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.handleLongTapGesture(gestureRecognizer:)))
        self.mapView.addGestureRecognizer(longPressTapGesture)
        configureMap()
        searchBar.delegate = self
    }
    
    @objc func handleLongTapGesture(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state !=  UIGestureRecognizer.State.ended {
            let touchLocation = gestureRecognizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
            
            print("Tapped at Latitude: \(locationCoordinate.latitude), Longitude: \(locationCoordinate.longitude)")
            
            let pin = MKPointAnnotation()
            pin.coordinate = locationCoordinate
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    var addressComponents = [String]()
                    
                    if let subThoroughfare = placemark.subThoroughfare {
                        addressComponents.append(subThoroughfare)
                    }

                    if let thoroughfare = placemark.thoroughfare {
                        addressComponents.append(thoroughfare)
                    }
                    
                    if let subLocality = placemark.subLocality {
                        addressComponents.append(subLocality)
                    }
                    
                    if let locality = placemark.locality {
                        addressComponents.append(locality)
                    }
                    
                    if let administrativeArea = placemark.administrativeArea {
                        addressComponents.append(administrativeArea)
                    }
                    
                    pin.title = addressComponents.isEmpty ? "Unknown Location" : addressComponents.joined(separator: ",")
                    
                    let alertController = UIAlertController(title: "Bu konumu kaydetmek istiyor musun?", message: nil, preferredStyle: .alert)
                            
                            let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
                            
                            let okAction = UIAlertAction(title: "Tamam", style: .default) { (_) in
                               
                                let newViewController = InfoViewController()
                                newViewController.locality = placemark.locality
                                newViewController.administrativeArea = placemark.administrativeArea
                                newViewController.subLocality = placemark.subLocality
                                if let thoroughfare = placemark.thoroughfare, let subThoroughfare = placemark.subThoroughfare {
                                    newViewController.address = "\(thoroughfare), \(subThoroughfare)"
                                } else if let thoroughfare = placemark.thoroughfare {
                                    newViewController.address = "\(thoroughfare)"
                                } else {
                                    newViewController.address = "Adres giriniz."
                                }

                                
                                self.navigationController?.pushViewController(newViewController, animated: true)
                                
                            }
                            
                            alertController.addAction(cancelAction)
                            alertController.addAction(okAction)
                            
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
            mapView.addAnnotation(pin)
        
        if gestureRecognizer.state != UIGestureRecognizer.State.began {
            return
            }
        }
    }
    
    func configureMap() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // BATTERY
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = kCLDistanceFilterNone
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         guard let searchQuery = searchBar.text else {
             return
         }
        searchBar.resignFirstResponder()
         searchLocation(query: searchQuery)
     }
    

    func searchLocation(query: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query) { (placemarks, error) in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("Lokasyon bulunamadı.")
                return
            }
//            let pin = MKPointAnnotation()
//            pin.coordinate = location.coordinate
//            if let address = placemark.thoroughfare {
//                pin.title = address
//            } else {
//                pin.title = "\(query)"
//            }
//            self.mapView.addAnnotation(pin)
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 800,longitudinalMeters: 800)
            self.mapView.setRegion(region, animated: true)
        }
    }
}
