//
//  MapVC.swift
//  D2020
//
//  Created by Macbook on 21/06/2021.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController , CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var latitude: Double = 29.97648
    var longitude: Double = 31.131302
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        let initialLocation = CLLocation(latitude: latitude , longitude: longitude)
        mapView.centerToLocation(initialLocation)
    }
    

    func setup(){
          locationManager.requestAlwaysAuthorization()
          locationManager.startUpdatingLocation()
          locationManager.delegate = self

    }
}
private extension MKMapView {
    func centerToLocation(
      _ location: CLLocation,
      regionRadius: CLLocationDistance = 1000
    ) {
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
  }
