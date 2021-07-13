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
    var latitude = "29.97648"
    var longitude = "31.131302"
    var storesArray = [StoesDataClass]()
    let annontation = MKPointAnnotation()
    var isShowingStores = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getStoreLocation()
        storesRequest()
        
        //        customMapAnnontation()
        
    }
    
    
    
    func setup(){
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        if isShowingStores{
            mapView.delegate = self
        }
        
    }
    
    
    
    // all stores location
    func storesRequest(){
        KRProgressHUD.show()
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/stores"
        guard let apiURL = URL(string: apiURLInString) else{ return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(Stores.self, from: result.data!) else{
                    return}
                self?.storesArray = apiResponseModel.data ?? [StoesDataClass]()
                self?.showStoresLocations()
                KRProgressHUD.dismiss()
                
            }
        
    }
    
    private func showStoresLocations(){
        guard let firstStore = storesArray.first else{ return }
        let title = firstStore.name ?? ""
        let firstStoreLocation = CLLocation(latitude: Double(firstStore.lati ?? "0.0") ?? 0.0 , longitude: Double(firstStore.longi ?? "0.0") ?? 0.0)
        self.mapView.centerToLocation(firstStoreLocation)
        let firstAnnotation = MKPointAnnotation()
        firstAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(firstStore.lati ?? "0.0") ?? 0.0 ,  longitude: Double(firstStore.longi ?? "0.0") ?? 0.0)
        firstAnnotation.title = title
        self.mapView.addAnnotation(firstAnnotation)
        mapView.selectAnnotation(mapView.annotations[0], animated: true)
        for i in 1..<storesArray.count{
            let title = storesArray[i].name ?? ""
            var annotaion = MKPointAnnotation()
            annotaion.coordinate = CLLocationCoordinate2D(latitude: Double(storesArray[i].lati ?? "0.0") ?? 0.0 ,  longitude: Double(storesArray[i].longi ?? "0.0") ?? 0.0)
            annotaion.title = title
            self.mapView.addAnnotation(annontation)
        }
    }
    
    // single store location
    func getStoreLocation(){
        KRProgressHUD.show()
        print(storeId)
        let apiURLInString = "\(APIConstant.BASE_URL.rawValue)user/store_details/\(storeId)"
        guard let apiURL = URL(string: apiURLInString) else{   return }
        Alamofire
            .request(apiURL, method: .get , parameters: nil, encoding: URLEncoding.default, headers: nil)
            .response {[weak self] result in
                let jsonConverter = JSONDecoder()
                guard let apiResponseModel = try? jsonConverter.decode(StoreDetails.self, from: result.data!) else{
                    return}
                
                self?.latitude = apiResponseModel.data?.data?.lati ?? ""
                self?.longitude = apiResponseModel.data?.data?.longi ?? ""
                let title = apiResponseModel.data?.data?.name ?? ""
                let initialLocation = CLLocation(latitude: Double(self?.latitude ?? "0.0") ?? 0.0 , longitude: Double(self?.longitude ?? "0.0") ?? 0.0)
                self?.mapView.centerToLocation(initialLocation)
                self?.annontation.coordinate = CLLocationCoordinate2D(latitude: Double(self?.latitude ?? "0.0") ?? 0.0 ,  longitude: Double(self?.longitude ?? "0.0") ?? 0.0)
                self?.annontation.title = title
                self?.mapView.addAnnotation(self?.annontation as! MKAnnotation)
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

extension MapVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "map@-12")
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
