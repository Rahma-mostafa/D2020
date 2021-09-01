//
//  StoreLocationVC.swift
//  D2020
//
//  Created by Macbook on 03/08/2021.
//

import UIKit
import CoreLocation
import MapKit

//search for location
protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class StoreLocationVC: UIViewController{
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var storeLocation: CLLocationCoordinate2D?
    var onLocationSelected: ((CLLocationCoordinate2D) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        definesPresentationContext = true
        addGestureToMap()
    }
    
    private func addGestureToMap(){
        let gestureRecognizer = UITapGestureRecognizer(
            target: self, action:#selector(handleMapTap))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleMapTap(gestureRecognizer: UITapGestureRecognizer) {
        mapView.removeAnnotations(mapView.annotations)
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        storeLocation = coordinate
    }
    
    @IBAction func onSaveButtonTapped(_ sender: Any) {
        guard let onLocationSelected = onLocationSelected else{ return }
        guard let storeLocation = storeLocation else{ return }
        onLocationSelected(storeLocation)
//        let storyboard = UIStoryboard(name: "Owner", bundle: nil)
//        let scene = storyboard.instantiateViewController(withIdentifier: "AddStoreVC") as!  AddStoreVC
//        scene.onLocationSelected = self.onLocationSelected
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension StoreLocationVC : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        mapView.removeAnnotations(mapView.annotations)
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        storeLocation = center
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error:: \(error)")
    }
}


