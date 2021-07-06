//
//  MapVC.swift
//  D2020
//
//  Created by Macbook on 21/06/2021.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import KRProgressHUD

class MapVC: UIViewController , CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var storeId = 0
    var latitude: Double? = 29.97648
    var longitude: Double? = 31.131302
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        let initialLocation = CLLocation(latitude: latitude ?? 0.0 , longitude: longitude ?? 0.0)
        mapView.centerToLocation(initialLocation)
        getStoreLocation()

    }

    

    func setup(){
          locationManager.requestAlwaysAuthorization()
          locationManager.startUpdatingLocation()
          locationManager.delegate = self

    }
    func getStoreLocation(){
            KRProgressHUD.show()
            print(storeId)
            let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/store_details/7"
            guard let apiURL = URL(string: apiURLInString) else{   return }
            Alamofire
                .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
                .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                    guard let apiResponseModel = try? jsonConverter.decode(StoreDetails.self, from: result.data!) else{
                        return}
                  
//                    self?.latitude = apiResponseModel.data?.data?.lati
//                    self?.longitude = apiResponseModel.data?.data?.longi
//
                    KRProgressHUD.dismiss()

                }
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
