//
//  StoreLocationVC.swift
//  D2020
//
//  Created by Macbook on 03/08/2021.
//

import UIKit
import CoreLocation
import MapKit


class StoreLocationVC: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func getUserCurrentLocation(){
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Handle location update
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        print(location.coordinate.latitude, location.coordinate.longitude)
        locationManager.stopUpdatingLocation()

        
//        if let location = locations.first {
//            let latitude = location.coordinate.latitude
//            let longitude = location.coordinate.longitude
//            print(latitude,longitude)
//        locationManager.stopUpdatingLocation()
//
//
//        }
    }
    
    // Handle failure to get a user’s location
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error){
    }
    // Get the current location permissions
//    func getCurrentLocationPermissions(){
//        let status = CLLocationManager.authorizationStatus()
//
//        // Handle each case of location permissions
//        switch status {
//            case.authorizedAlways:
//                // Handle case
//            case.authorizedWhenInUse:
//                // Handle case
//            case.denied:
//                // Handle case
//            case.notDetermined:
//                // Handle case
//            case.restricted:
//                // Handle case
//        }
//    }
  

    func locationManagerLastUpdate( _ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]){
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
            print(latitude,longitude)

        }
    }

   
}
