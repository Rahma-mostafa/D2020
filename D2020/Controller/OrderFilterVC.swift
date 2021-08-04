//
//  OrderFilterVC.swift
//  D2020
//
//  Created by Macbook on 01/07/2021.
//

import UIKit
import CoreLocation


class OrderFilterVC: BaseController, CLLocationManagerDelegate {
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var newBtn: UIButton!
    @IBOutlet weak var mostVisitBtn: UIButton!
    var index = 0
    var subcategoryId = 0
    let locationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hiddenNav = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()


    }
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let mylocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        print(location.coordinate.latitude, location.coordinate.longitude)
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        print(mylocation)
        locationManager.stopUpdatingLocation()
        
//        if let location = locations.first {
//            self.latitude = location.coordinate.latitude
//            self.longitude = location.coordinate.longitude
//            print(latitude,longitude)
//        locationManager.stopUpdatingLocation()
//        }
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNav(){
        let storyboard = UIStoryboard(name: "Category", bundle: nil)
        let scene = storyboard.instantiateViewController(identifier: "SubcategoryStoresVC") as! SubcategoryStoresVC
        scene.index = self.index
        scene.subcategoryId = self.subcategoryId
        scene.latitude = self.latitude
        scene.longitude = self.longitude
        navigationController?.pushViewController(scene, animated: true)
    }
    
   
   
    
    @IBAction func onOlderBtnTapped(_ sender: Any) {
        self.index = 0
        setNav()
    }
    
    @IBAction func onNewBtnTapped(_ sender: Any) {
        self.index = 1
        setNav()
    }
    

    @IBAction func onMostVisitBtn(_ sender: Any) {
        self.index = 2
        setNav()
    
    }
    
    @IBAction func onNearByBtnTapped(_ sender: Any) {
        self.index = 3
        setNav()

    }
    
    
    @IBAction func onCancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
