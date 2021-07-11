//
//  SelectMapVC.swift
//  D2020
//
//  Created by Macbook on 11/07/2021.
//

import UIKit

class SelectMapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func navigateToMap(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let scene = storyboard.instantiateViewController(withIdentifier: "MapVC") as!  MapVC
        navigationController?.pushViewController(scene, animated: true)
    }
    


    @IBAction func onStoresBtnTapped(_ sender: Any) {
        navigateToMap()
    }
    
    @IBAction func onDelegateBtnTapped(_ sender: Any) {
        navigateToMap()
    }
}
