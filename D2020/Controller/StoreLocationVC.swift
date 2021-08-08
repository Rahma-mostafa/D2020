//
//  StoreLocationVC.swift
//  D2020
//
//  Created by Macbook on 03/08/2021.
//

import UIKit
import CoreLocation
import MapKit

// user location in map kit

//class StoreLocationVC: UIViewController, CLLocationManagerDelegate{
//    @IBOutlet weak var mapView: MKMapView!
//    let locationManager = CLLocationManager()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    func getUserCurrentLocation(){
//        locationManager.requestLocation()
//        locationManager.requestWhenInUseAuthorization()
//    }
//
//    // Handle location update
//    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let region:MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
//        mapView.setRegion(region, animated: true)
//        self.mapView.showsUserLocation = true
//        print(location.coordinate.latitude, location.coordinate.longitude)
//        locationManager.stopUpdatingLocation()
//    }
//
//    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print("error:: \(error)")
//    }
//}





//search for location
    protocol HandleMapSearch {
        func dropPinZoomIn(placemark:MKPlacemark)
    }

class StoreLocationVC: UIViewController{
    @IBOutlet weak var mapView: MKMapView!
    var selectedPin:MKPlacemark? = nil
    var resultSearchController:UISearchController? = nil
    let locationManager = CLLocationManager()
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }
        
    @objc func getDirections(){
            if let selectedPin = selectedPin {
                let mapItem = MKMapItem(placemark: selectedPin)
                let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps(launchOptions: launchOptions)
            }
        }
    }

    extension StoreLocationVC : CLLocationManagerDelegate {
        private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                locationManager.requestLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
            let location = locations[0]
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region:MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
            mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
            self.location = location
            print(location.coordinate.latitude, location.coordinate.longitude)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
            print("error:: \(error)")
        }
    }

    extension StoreLocationVC: HandleMapSearch {
        func dropPinZoomIn(placemark:MKPlacemark){
            // cache the pin
            selectedPin = placemark
            // clear existing pins
            mapView.removeAnnotations(mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = placemark.coordinate
            annotation.title = placemark.name
            if let city = placemark.locality,
                let state = placemark.administrativeArea {
                    annotation.subtitle = "\(city) \(state)"
            }
            mapView.addAnnotation(annotation)
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    extension StoreLocationVC : MKMapViewDelegate {
        private func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
            if annotation is MKUserLocation {
                //return nil so map view draws "blue dot" for standard user location
                return nil
            }
            let reuseId = "pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.pinTintColor = UIColor.orange
            pinView?.canShowCallout = true
            let smallSquare = CGSize(width: 30, height: 30)
            let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
            button.setBackgroundImage(UIImage(named: "marker_store"), for: .normal)
            button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
            pinView?.leftCalloutAccessoryView = button
            return pinView
        }
    }
